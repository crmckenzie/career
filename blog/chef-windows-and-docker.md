# Chef, Windows, & docker

At Redacted Industries we use Chef to deploy our applications to various environments. An environment for us is a complete set of servers and applications configured to talk to one another. Environments are designed to mirror prod as much as possible.

The majority of our applications are written in C# and target the Windows operating system. Accordingly, developers are assigned a windows VDI and given access to a spate of tools for Windows-based development.

Our DevOps group on the other hand primarily works in Chef & Ruby. Their standard-issue hardware is a Macbook Pro.

## Ruby on Windows

Ruby is less than awesome on Windows. There are a host of issues, but the main problem is that gem does not want to install binaries to the host OS. Rather, gems that require C-compilation are built from source when they are installed on the target OS. Gem developers do not always test their C-compilation on both Linux & Windows so Windows compilation is often neglected.

The community attitude toward this problem tends toward "Show me the PR!" This is a typical attitude in open-source, but few modern developers have the stamina to master the vagaries of C-compilers so the reality is these sorts of problems are seldom touched.

Despite these problems, I am able to develop Ruby applications on Windows with relative ease. It takes some time and effort to learn where the dragons are and slay them, but it can be done.

## ChefDK & Embedded Rubies

Ruby devs often want to build gems against different versions of Ruby. Controlling which version of ruby you're using at any one time is a challenge. There are tools such as rvm & rbenv to help but the tools are not awesome. To further complicate matters, OS/X comes with its own embedded Ruby as does ChefDK.

It is a challenge to keep straight which code is supposed to be installed in and run in the context of which version or Ruby, especially since Chef can be used to install versions of Ruby different than what it is running under. Further, the ChefDK is not designed to play-nice with other Rubies. In discussions with the developers at OpsCode, they say that the ChefDK is designed for people who are not going to be developing Ruby applications in any environment other than Chef. It becomes problematic when the Chef docs tell you to install certain gems and you end up installing them into the wrong Ruby. Gah!

## Docker

If you haven't read about Docker yet, stop reading this blog and go read about Docker. Docker lets you create lightweight VMs known as containers. A container isn't really a VM--it's a process. I think of it as a process that _thinks_ it's a VM.

What if we could create a docker container pre-configured with the ChefDK such that the Chef tools are deployed correctly in a way that is isolated from my other Rubies? Ideally, I'd be able to point the ChefDK container to my local source files on Windows. I can still be on the network, have access to email and company chat, use my favorite text editors--but when I need chef commands, I can duck into the container context long enough to do what I need to do there and get out.

Sounds awesome!

### The DockerFile

A Dockerfile is a description of an image that you wish to build. Here is a sample:

```Dockerfile
FROM ubuntu
MAINTAINER Chris McKenzie <crmckenzie@redacted.com>

RUN apt-get update
RUN apt-get install -y curl git build-essential libxml2-dev libxslt-dev wget lsb-release

# RUN curl -L https://www.opscode.com/chef/install.sh | sudo bash
### INSTALL CHEFDK
RUN wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.6.2-1_amd64.deb
RUN dpkg -i chefdk_0.6.2-1_amd64.deb && rm chefdk_0.6.2-1_amd64.deb

RUN chef verify

### CLEANUP
RUN apt-get autoremove
RUN apt-get clean
```

First, you use the Dockerfile to build the image.

```
docker build -t chef-workstation .
```

### The Powershell Script

To make the Docker image usable, I need to create containers from it.  Containers are _instances_ of an image that you can use. Containers are _disposable_. To that end let's write some powershell to wrap up complex docker commands into something I can call easily.

```powershell
  $username = $env:UserName

  function Invoke-Knife() {
    $cmd = "docker run --entrypoint=knife --rm -w='/root/src' -v /c/Users/$username/.chef:/root/.chef -v /c/Users/$username/src:/root/src -it chef-workstation $args"
    write-debug $cmd
    Invoke-Expression $cmd
  }

  function Invoke-Chef(){
    $cmd = "docker run --entrypoint=chef  --rm -w='/root/src' -v /c/Users/$username/.chef:/root/.chef -v /c/Users/$username/src:/root/src -it chef-workstation $args"
    write-debug $cmd
    Invoke-Expression $cmd
  }

  set-alias knife Invoke-Knife
  set-alias chef Invoke-Chef
```

This script defines 2 functions: `Invoke-Knife` and `Invoke-Chef`. Let's break this command down step by step.

* docker run
```
This command runs a container
```
* --entrypoint=knife
```
Tells Docker to execute 'knife' automatically when the container is created.
```
* --rm
```
Tells Docker to remove the container after its process stops.
```
* -w='/root/src'
```
Tells Docker to run 'knife' in the working directory '/root/src'
```
* -v /c/Users/$username/.chef:/root/.chef
```
Tells Docker to share the .chef directory from the Host OS to '/root/.chef'
```
* -v /c/Users/$username/src:/root/src
```
Tells Docker to share the src directory from the Host OS to '/root/src'
```
* -it chef-workstation
```
Tells Docker to allocate a tty for the container process and create the container from the 'chef-workstation' image
```

* $args
```
This is the powershell variable containing the arguments passed to `Invoke-Knife`. These arguments are simply forwarded to knife when the container is executed.
```

### What Happens Next?

When I execute 'knife search "*:*"', 'knife' is an alias that executes Invoke-Knife--which starts the container and passes 'search "*:*"' to the knife executable in the container. As soon as the 'knife' process finishes its work and emits its results, the container is shut down and deleted.  If I execute 'chef generate cookbook fredbob', a similar process happens except that the 'chef' executable creates a cookbook in '/root/src' on the container--which is mapped to my source directory on Windows. Both executables use the chef credentials I've defined in my .chef directory on my Host OS.

## Feedback

I'm putting this out there because I've found it helpful, however there may be simpler, better ways of doing things. I'm open to comments and suggestions for other ways to resolve any of these issues, or for more interesting ways to use Docker.
