# Octopus Deploy - Roles

DevOps is a relatively new space in the software engineering world. There are a smattering of tools to aid in the automation of application deployments, but precious little guidance with respect to patterns and practices for using the new tools. As a guy who loves leaning on principles this lack of attention to best practices leaves me feeling a bit uncomfortable. Since I'm leading a migration to [Octopus Deploy], I thought I would share some of the decisions we've made.

I want to be clear: We have not been applying these ideas long enough to know what all of the ramifications are. Your mileage may vary.

# Roles

When you add machines into Octopus, you must specify environments and roles for that machine. For our purposes, environments were pretty easy to define. Roles, however, took some work. Here are the kinds of roles we defined.

## Operating Systems

**Example: windows, linux**

This is pretty easy. We started with `Linux` and `Windows` for this type of role. I can see a day when we may need to additionally specify `ubuntu-14` or `2k8-r2`. In the meantime, [YAGNI].

## Environment Types

**Example: dev, uat, integration, staging, prod, support**

Our environment naming convention for developer environments is `dev-{first initial}{last name}` For uat environments it's `uat-{team}`. There is only one integration, staging, and production environment. There are certain variables that are defined consistently across all `dev` environments but may differ in `uat` environments. For this reason we are applying the environment type as a role across all machines in the relevant environments.

## Commands

**Example: hero-db**

This is a standalone role. There will only be one machine in each environment that will have this role. It's purpose is to execute commands on some resource in the enviornment that should not be run multiple times concurrently. A good example of this is an Entity Framework database migration. We choose one machine in an environment that database migrations can be run from.

## Applications

**Example: webapp-iis, topshelf-service**

Each deployable application has its own role. Not every application gets installed on every machine in an environment. We use the `-iis` affix for applications installed into IIS regardless of whether they're sites or web services. We use the `-service` affix for Windows Services.
