# Powershell: How to Structure a Module

There doesn't seem to be much guidance as to the internal structure of a Powershell module. There's a lot of "you can do it this way or that way" guidance, but little "this has worked well for me and that hasn't." As a patterns and practices guy, I'm dissatisfied with this state of affairs.  In this post I will describe the module structure I use and the reasons it works well for me.

I've captured the structure in a [sample module](https://github.com/crmckenzie/Posh) for you to reference.

![Powershell Module Structure](images/powershell-module-structure.jpg)

## Posh.psd1

This is a [powershell module manifest](https://technet.microsoft.com/en-us/library/dd878297(v=vs.85).aspx). It contains the metadata about the powershell module, including the name, version, unique id, dependencies, etc.. 

It's very important that the Module id is unique as re-using a GUID from one module to another will potentially create conflicts on an end-user's machine.

I don't normally use a lot of options in the manifest, but having the manifest in place at the beginning makes it easier to expand as you need new options. Here is my default `psd1` implementation:

```powershell
# Version number of this module.
ModuleVersion = '1.0'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '2a97124e-d73e-49ad-acd7-1ea5b3dba0ba'

# Author of this module
Author = 'chmckenz'

# Company or vendor of this module
CompanyName = 'ISG Inc'

# Copyright statement for this module
Copyright = '(c) 2018 chmckenz. All rights reserved.'

ModuleToProcess = "Posh.psm1"

```



## Posh.psm1

This is the module file that contains or loads your functions. While it is possible to write all your module functions in one file, I prefer to separate each function into its own file. 

My `psm1` file is fairly simple.

```powershell
gci *.ps1 -path export,private -Recurse | %{
    . $_.FullName
}

gci *.ps1 -path export -Recurse | %{
    Export-ModuleMember $_.BaseName
}
```

The first `gci` block loads all of the functions in the `export` and `private` directories. The `-Recurse` argument allows me to group functions into subdirectories as appropriate in larger modules.

The second `gci` block exports only the functions in the `Export` directory. Notice teh use of the `-Recurse` argument again.

With this structure, my `psd1` & `psd1` files do not have to change as I add new functions.


## Export Functions

I keep functions I want the module to export in this directory. This makes them easy to identify and to export from the `.psm1` file.

It is important to distinguish functions you wish to expose to clients from private functions for the same reason you wouldn't make every class & function `public` in a nuget package. A Module is a library of functionality. If you expose its internals then clients will become dependent on those internals making it more difficult to modify your implementation. 

You should think of public functions like you would an API. It's shape should be treated as immutable as much as possible.

## Private Functions

I keep helper functions I do not wish to expose to module clients here. This makes it easy to exclude them from the calls to `Export-ModuleMember` in the `.psm1` file. 

## Tests

The `Tests` directory contains all of my [Pester](https://github.com/pester/Pester) tests. Until a few years ago I didn't know you could write tests for Powershell. I discovered `Pester` and assigned a couple of my interns to figure out how to use it. They did and they tought me. Now I can practice TDD with Powershell--and so can you.

## Other potential folders

When publishing my modules via [PowershellGallery](http://www.powershellgallery.com/) or [Chocolatey](https://chocolatey.org/) I have found it necessary to add additional folders & scripts to support the packaging & deployment of the module. I will follow up with demos of how to do that in a later post.

# Summary

I've put a lot of thought into how I structure my Powershell modules. These are my "best practices," but in a world where Powershell best practices are rarely discussed your mileage may vary. Consider this post an attempt to start a conversation.
