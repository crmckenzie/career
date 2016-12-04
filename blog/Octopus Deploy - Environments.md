DevOps is a relatively new space in the software engineering world. There are a smattering of tools to aid in the automation of application deployments, but precious little guidance with respect to patterns and practices for using the new tools. As a guy who loves leaning on principles this lack of attention to best practices leaves me feeling a bit uncomfortable. Since I'm leading a migration to [Octopus Deploy], I thought I would share some of the decisions we've made.

I want to be clear: We have not been applying these ideas long enough to know what all of the ramifications are. Your mileage may vary. This series of posts is an attempt to start a conversation about best practices.

# Our Default Lifecycle

Before I begin, I should give you some background on our development ecosystem. Our Octopus Lifecycle looks like this:

```
dev => uat => integration => staging => prod => support
```

# The Environments

<table>
    <thead>
        <th width="20px">Name</th>
        <th width="150px">Convention</th>
        <th width="200px">Purpose</th>
        <th >Notes</th>
    </thead>
    <tbody>
        <tr>
            <td>dev</td>
            <td style="width:40px">dev-{first initial}{last name}</td>
            <td>The primary purpose of these environments is to test the deployment tooling itself.</td>
            <td>We have 15 or so individual developer environments. Each developer gets their own environment with 2 servers (1 Linux, 1 Windows) and all of our 60 or so proprietary applications installed to it.</td>
        </tr>
        <tr>
            <td>uat</td>
            <td>uat-{team}</td>
            <td>These environments are used by teams to test their work.</td>
            <td>We have 10 or so User Acceptance Testing environments. These are a little bit more fleshed out in terms of hardware. There are multiple web servers behind load balancers. The machines are beefier. These enviornments are usually owned by a single team, though they may sometimes be shared.</td>
        </tr>
        <tr>
            <td>integration</td>
            <td>N/A</td>
            <td>Dress rehearsal by Development for releases</td>
            <td>The integration environment is much closer to production. When multiple teams are releasing their software during the same release window, integration gives us a rehearsal environment to make sure all of the work done by the various teams will work well together.</td>
        </tr>
        <tr>
            <td>staging</td>
            <td>N/A</td>
            <td>Dress rehearsal by Support for releases</td>
            <td>Staging is exactly like integration except that it is not owned by the Development department. We have a team of people who are responsible for executing releases. This is their environment to verify that the steps development gave them will work.</td>
        </tr>
        <tr>
            <td>prod</td>
            <td>N/A</td>
            <td>Business Use</td>
            <td>Prod is not managed by the deployment engineering team. We build the button that pushes to prod, but we do not push it.</td>
        </tr>
    </tbody>
</table>



| support | N/A | Rehearsal environment for support solutions | Support is a post-production environment that mirrors production. It allows support personnel to test and verify support tasks in a non-prod environment prior to running them in production. |

[Octopus Deploy]: https://octopus.com/

