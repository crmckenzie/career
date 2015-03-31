# Vim

I'm assuming you'd rather not compile Vim for Windows yourself. I don't blame you. I tried it and it's a nightmare.

These are manual steps, unfortunately. :(

For the best vim experience you should get the version compiled with Ruby and Python support.

Ruby and Python support does not necessarily mean that you will be coding in Ruby or Python, but many of the plugins that you will want to use require vim integration with Ruby and Python.

## Install Ruby

    choco install ruby -Version 2.0.0.59800

If you need other version of ruby, go ahead and install them now.

### Uru

You only need to install uru if you are using multiple rubies. Rvm does not work on Windows and Pik is no longer supported. Uru works fine.

[Install Uru](https://bitbucket.org/jonforums/uru)

You'll need to add your ruby installations to uru using

	uru admin add /path/to/ruby/bin

## Installing Python

	choco install Python


## Install Vim

Now you are ready to install vim.
Unfortunately, the version available on Chocolately.org is hard to get to work with Ruby and Python on Windows.
However, Alexander Shukaev (Haroogan) has compiled a version that works nicely.

[Download Vim from Here](https://bitbucket.org/Haroogan/vim-for-windows/overview)

Extract the zip file where you want it and make sure the location of vim.exe is in the path before any other vims on your system (for example, if you have msysgit installed).

## Verification

If this works, you should be able to execute the following commands in vim.

	:echo has('ruby') => 1
	:echo has('python') => 1


## Install Vundle

    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

### Install Bundles

Open vim and run :BundleInstall.
This should download the bundles specified in .vimrc


## Install .vimrc

I keep my [.vimrc file](https://gist.github.com/crmckenzie/4913add34cd30abd4b93) as a gist.

I clone it into my C:\git directory.

    git clone https://gist.github.com/crmckenzie/4913add34cd30abd4b93 vimrc

Then I create a symlink from my $HOME directory to the vimrc file. This allows me to maintain the file across machines using git as a synchronization tool.

From powershell

    cmd /C mklink .vimrc C:\git\vimrc\.vimrc

