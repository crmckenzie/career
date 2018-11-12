DevOps is all the rage. It's the new fad in tech! Years ago we were saying we should rely less on manual testing and fold testing into our engineering process. Now we are saying we should rely less on manual deployments and fold deployments and operational support into our engineering process. This all sounds lovely to me!

Having been a part of this effort toward automating more and more of our engineering process for the bulk of my career, I've had the opportunity to see CI/CD initiatives go awry. Strangely, it's not self-evident how to setup a CI/CD pipeline well. It's almost as if translating theory into practice is where the work is.

There are several inter-related subject-areas that need to be aligned to make a CI/CD pipeline successful. They are:

* [Source Control](#source-control)
* [Branching Strategy](#branching-strategy)
* [Automated Build](#automated-build)
* [Automated Testing](#automated-testing)
* [Build Artifacts](#build-artifacts)
* [Deployment Automation](#deployment-automation)
* [Environment Segregation](#environment-segregation)

Let's talk about each of them in turn.

# Source Control
Your code is in source control right? I hate to ask, but I'm surprised by how often I have encountered code that is not in source control. A common answer I get is "yes, except for these 25 scripts we use to perform this or that task." That's a "no." _All_ of your code needs to be in source control. If you're not sure where to put those scripts, create a `/scripts` folder in your repo and put them there. Get them in there, track changes, and make sure everyone is using the same version.

It's customary for the repo structure to look something like

    /src
    /build
    /docs
    /scripts
    /tests
    README.md
    LICENSE.md

I also encourage you to consider adopting a 1 repo, 1 root project, 1 releasable component standard separating your repositories.

# Branching Strategy
You should use a known, well-documented branching strategy. The goal of a branching strategy is to make sure everyone knows how code is supposed to flow through your source control system from initial development to the production release. There are three common choices:

| Feature Branch | Git Flow | Commit to Master |
| --- | --- | --- |
| Feature branches are taken from master. Features are developed and released separately. They are merged to master at release time. Appropriate for smaller teams who work on one feature at a time. Continuous Integration happens on the `feature` branch. | More sophisticated version of feature branching. Allows multiple teams to work in the project simultaneously while maintaining control over what gets released. Appropriate for larger teams or simultaneous feature development is needed. Continuous Integration happens on the `develop` branch. | For mature DevOps teams. Use feature flags to control what code is active in production. Requires lifecycle management of feature flags. Continuous Integration happens on `master`.|

Some purists will argue that Continuous Integration isn't happening unless you're doing Commit to Master. I don't agree with this. My take is that as long as the team is actively and often merging to the same branch, then the goal of Continuous Integration is being met.

# Automated Build
Regardless of what programming language you are using, you need an automated build. When your build is automated, your build scripts become a living document that removes any doubt about what is required to build your software. You will need an automated build system such as [Jenkins](1), [Azure DevOps](2), or [Octopus Deploy](3).  You need a separate server that knows how to run your build scripts and produce a [build artifact](#build-artifacts). It should also programmatically execute any quality gates you may have such as credentials scanning or [automated testing](#automated-testing). Ideally, any scripts required to build your application should be in your repo under the `/build` folder.

# Automated Testing
Once you can successfully build your software consistently on an external server (external from your development workstation), you should add some quality gates to your delivery pipeline. The first, easiest, and least-expensive quality gate should be unit tests. If you have not embraced [Test Driven Development](#tdd), do so. If your Continuous Integration server supports it, have it verify that your software builds and passes your automated tests at the pre-commit stage. This will prevent commits from making it into your repo if they don't pass feature. If your CI server does not support this feature, make sure repairing any failed builds or failed automated testing is understood to be the #1 priority of the team should they go red.

# Build Artifacts
Once the software builds successfully and passes the initial quality gates, your build should produce an artifact. Examples of build artifacts include nuget packages, maven packages, zip files, rpm files, or any other standard, recognized package format.

Build artifacts should have the following characteristics:

* **Completeness**. The build artifact should contain everything necessary to deploy the software. Even if only a single component changed, the artifact should be treated like it is being deployed to a fresh environment.
* **Environment Agnosticism**. The build artifact should not contain any information specific to any environment in which it is to be deployed. This can include URL's, connection strings, IP Addresses, environment names, or anything else that is only valid in a single environment. I'll write more about this in [Environment Segregation](#environment-segregation).
* **Versioned**. The build artifact should carry it's version number. Most standard package formats include the version in the package filename. Some carry it as metadata within the package. Follow whatever conventions are normally used for your package management solution. If it's possible to stamp the files contained in the package with the version as well (e.g., .NET Assemblies), do so. If you're using a zip file, include the version in the zip filename. If you are releasing a library, follow [Semantic Versioning](#3). If not, consider versioning your application using release date information (e.g., 2018.8.15 for a release started on August 15th, 2018, or 1809 for a release started in September of 2018.)
* **Singleton**. Build artifacts should be built only once. This ensures that the build you deploy to your test environment will be the build that you tested when you go to production.

# Deployment Automation
Your deployment process should be fully automated. Ideally, your deployment automation tools will simply execute scripts they find in your repo. This is ideal because it allows you to version and branch your deployment process along with your code. If build your release scripts in your release automation tool, you will have integration errors when you need to modify your deployment automation for different branches independently.

The output of your build process is a build artifact. This build artifact is the input to your deployment automation, along with configuration data appropriate to the environment you are deploying to.

Taking the time to script your deployment has the same benefits as scripting your build--it creates a living document detailing exactly how your software must be deployed. Your scripts should assume a clean machine with minimal dependencies pre-installed and should be re-runnable without error. 

Take advantage of the fact that you are versioning your build artifact. If you are deploying a website to IIS, create a new physical directory matching the package and version name. After extracting the files to this new directory, repoint the virtual directory to the new location. This makes reverting to the previous version easy should it be necessary as all of the files for the previous version are still on the machine. The same trick can be accomplished on Unix-y systems using sym-links.

Lastly, your deployment automation scripts are code. Like any other code, it should be stored in source control and _tested_. 

# Environment Segregation
I've told you to avoid including any environment-specific configuration in your build artifact (and by extension, in source control), and I've told you to fully automate your deployment process. The configuration data for the target environment should be defined in your deployment automation tooling. 

Most deployment automation tools support some sort of variable substitution for config files. This allows you to keep the config files in source control with defined placeholders where the environment-specific configuration would be. At deployment time, the deployment automation tools will replace the tokens in the config files with values that are meaningful for that environment.

If variable substitution is not an option, consider maintaining a parameter-driven build script that writes out all your config files from scratch. In this case your config files will not be in source control at all but your scripts will know how to generate them.

The end-result of all of this is that you should be able to select any version of your build, point it to the environment of your choice, click "deploy," and have a working piece of software.

# Epilogue
The above is not a complete picture of everything you need to consider when moving towards DevOps. I did not cover concepts such as post-deployment testing, logging & monitoring, security, password & certificate rotation, controlling access to production, or any number of other related topics. I did however cover things you should consider when _getting started_ in CI/CD.  I've seen many teams attempt to embrace DevOps and make these errors. Following this advice should save you the effort of making these mistakes and give you breathing room to make new ones :). 

