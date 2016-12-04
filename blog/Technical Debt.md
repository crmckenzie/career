# Deferred Technical Debt is Just Bad Design

[Technical Debt] is a metaphor to describe software rot. The idea is that each time software engineers take shortcuts in the code they incur "debt" in the code base. Each time future engineers must read and/or modify the indebted code, they pay "interest" on the debt in the form of longer project times and increased risk of defects due to unreadable code.

Some argue, and I'm one of them, that sometimes it is necessary to incur technical debt for the sake of speed. In a personal example I had a feature that was required to be implemented inside a week. My team estimated the work at 2 weeks. This was unacceptable due to an externally imposed deadline. The team offered a hacky solution to the problem that resulted in a quick turnaround. We offered the solution _on the condition that we would immediately be given the 2 weeks to correct the design flaw_. Agreement was reached and we released the feature in 1 week. We _finished_ the feature in 3 weeks.

When you take on technical debt, you don't reduce the cost of the feature--you _increase_ it. You take on the work of the hacky solution _and_ the work of _reworking_ the hacky solution.

The reason we were able to reach this agreement is that our product owner and our team all understood that _bad code is more expensive_. We diliberately wrote bad code for the sake of instant gratification _and then we immediately paid the full price_ for good, tested code.

# We'll Fix It Later

My colleage @jrolstad likes to say

> Technical Debt is the lie we tell ourselves that we'll come back and fix it later.

This is a phenomenon widely observed by many software engineers. We complain that the software is rotting and are promised an opportunity to "fix it later," but "later" never seems to come.

> What is always coming but never arrives? _Tomorrow_

**-- Children's joke**

# Your Code is Your Design

There's an antipathy toward useless documentation in the Agile community, especially documentation about what code does. "The best documentation of the code is the code."

When it comes to the design of their software, many developers make the mistake of thinking of the system in terms of their aspirations for the codebase. The design of the system is always its current state. If you take a policy of accumulating technical debt in your codebase then your actual design is a mess--not the gleaming structure of rationality you imagine it will be when you fix the technical debt... _later_.

# What can we do?

If your organization has a legitmate need to take on technical debt, we can insist that the work to repair the debt be placed on the work calendar immediately.  Most of the time the "business value" of getting a feature delivered fast is an attempt to pretend that a feature doesn't cost as much as it does.

As a software engineering professional, we should not pretened that features do not cost what they do. We should not _lie_ to the business, nor help them lie to themselves.

# Estimation

These ideas have an implication with respect to estimation. If you owned a home and wanted to add a room on the second floor, how would you react if your contractor said "Well, these beams are rotted. We can probably build the room without replacing the beams, but your house may collapse in ten years. What do you want to do?" If you are anything like me, you would be appalled that the contractor even offered the option. The fact that the beams are rotted requires that they be replaced. This is not optional. The problem is not "solved" by building a room on rotted beams that will collapse in 10 years. It is not solved even if we know we are going to sell the house in 5 years (I'm looking at you startups). 

The engineer should not offer to build the room on rotted beams. We should not offer or suggest alternatives to the business that result in the accumulation of technical debt. We should be _honest_ with ourselves and with our employers about the real cost of the work they have requested.

# But What if There's a Legitimate Reason?

Is it always wrong to accrue technical debt? I don't think so. As I stated earlier, I believe it can be acceptable to take some short-term shortcuts to get a solution out fast. However, this should be anomalous and the resultant mess should be cleaned up immediately following the achievement of the business goal.  It needs to be understood by all parties that the shortcut costs more, not less.

# How do I Sell This to the Business?

This is a complex topic and I don't have all the answers. I have _some_ answers and some promising leads.

First, stop presenting hacky alternatives in your estimate. Look at the code and honestly assess what it will take to alter it correctly. What is it going to take to add appropriate tests where they are missing? To clean the code so it will tolerate the change? To make the change? To repair an architectural deficiency? Estimate and present your estimate confidently and do not offer hacky options. If the business wants to negotiate, ask which features they would like to drop from the project. Do not offer to take engineering shortcuts.

Another tactic you can take is to measure estimates vs. technical debt in the code.  You'll have to start collecting some data for this approach and it will take some time. You'll need:

* Project estimates
* How long the projects actually took
* [Cycolmatic] complexity for the affected code.

[Technical Debt]: https://en.wikipedia.org/wiki/Technical_debt
[Cyclomatic]: https://en.wikipedia.org/wiki/Cyclomatic_complexity
