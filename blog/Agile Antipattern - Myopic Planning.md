I recently came across this tweet:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">The most scathing (and generally valid) criticism of &quot;Agile&quot; and Scrum I&#39;ve ever read. Please read and RT.<a href="https://t.co/Pc85bBdiiA">https://t.co/Pc85bBdiiA</a></p>&mdash; Michael Ibarra (@bm2yogi) <a href="https://twitter.com/bm2yogi/status/717346542198267904">April 5, 2016</a></blockquote>
<script async src="https//platform.twitter.com/widgets.js" charset="utf-8"></script>

Read the entire article. It’s fascinating. Here are some choice quotes:

    work gets atomized into “user stories” and “iterations” that often strip a sense of accomplishment from the work, as well as any hope of setting a long-term vision for where things are going.
    ...
    Instead of working on actual, long-term projects that a person could get excited about, they’re relegated to working on atomized, feature-level “user stories” and often disallowed to work on improvements that can’t be related to short-term, immediate business needs (often delivered from on-high).
    ...
    the sorts of projects that programmers want to take on, once they master the basics of the craft, are often ignored, because it’s annoying to justify them in terms of short-term business value. Technical excellence matters, but it’s painful to try to sell people on this fact if they want, badly, not to be convinced of it.
    ...
    Under Agile, technical debt piles up and is not addressed because the business people calling the shots will not see a problem until it’s far too late or, at least, too expensive to fix it.  Moreover, individual engineers are rewarded or punished solely based on the optics of the current two-week “sprint”, meaning that no one looks out five “sprints” ahead. Agile is just one mindless, near-sighted “sprint” after another: no progress, no improvement, just ticket after ticket after ticket.

I can summarize my own views on Scrum by saying "Scrum is a process that teaches a team how not to need Scrum." I'll likely expand on that idea later, but it is not the focus of this post.

# Short Term Planning

A common theme running through many of Church's criticisms is the failure to plan long-term.  Larger engineering tasks do not get done because they cannot fit into an arbitrarily short time-frame. Technical debt gets ignored. Software rots and [it is regarded as normal].

Church places the blame on Scrum and appears to argue that engineers should be in charge of the project planning so that they can take on the larger, longer-term, more-expensive iniatives that will ultimtely save the company money.

# Checks & Balances

We've tried that. That was the default state of the industry since its inception. Software engineering was akin to black-magic to most people, but for others it's just grunt-work. (I once had a supervisor say to me in all seriousness "I had a class in C in college. A loop is a loop right? Anybody can do this.") Software engineers would spend their time building systems and frameworks for features that were ultimately not needed. (They still do. Watch [this talk] by [Christin Gorman] for a real-world example in a modern project.) This tendency of engineers to "gold-plate" their code or work on "what's cool" resulted in huge expense-overruns for software that was delivered late, over-budget, and often did not do what was expected of it.

In an attempt to get some kind of control over engineering projects The Business started taking more direct control over software projects. Since they could not trust the engineers to stay focused on delivering business value, they ruthlessly began cutting anything that did not directly contribute to features they could see. This was a problem because they did not often understand the tradeoffs they were making which resulted in software what did what it was supposed to in v1, but became harder and harder to maintain over time due to poor engineering.

Agile/Scrum attempts to address this problem by creating a clear separation of responsibilities. The Business is responsible for feature definition and prioritization. Development is responsible for estimation and implementation. The Business decides _what_ is built and _when_ but Development is in control of _how_. Instead of trying to teach The Business software engineering, Development communicates about alternatives in terms of _estimates_ and _risks_. 

    Development: If you choose strategy 'A', we estimate it will take this long with these risks. If you choose strategy 'B', it will take longer, but have fewer risks.

# Committment

In order for this division of labor to be successful, each party must _commit_ to it. Introducing a Scrum (or any other) process to a team does not make the team agile. Just because the engineers practice TDD and practices Continuous Integration, Continuous Deployment and other good engineering practices does not mean the team is agile. 

The Business is part of the team. It is the Business' responsibility to do the long-term planning. It is the engineer's responsibility to communicate about estimates and risk. If either party fails to do their part, it is not a failure of "Agile," but a failure of the people involved. 

You might me attempted to accuse me of the "[No True Scotsman]" fallacy at this point. If so, then you are missing my point. The Agile Software movement is focused on a philsophy for interacting with The Business which values the contributions of all stakeholders and encourages trust. It is not a prescription for particular processes. No process will succeed if the stakeholders do not buy into the underlying philosophy.

Agile is about the people. It's right there in [the manifesto].

    Individuals and interactions over processes and tools
    
An observant critic might respond at this point by pointing to another pieces of the manifesto:

    Responding to change over following a plan
    
Isn't this an endorsement of short-term thinking? No. At the time the manifesto was written, it was much more likely that software would be written in months or years-long iterations. This created a problem in that business circumstances would change in ways that diminished the value of planned features before they were delivered. It is not an injunction against planning _per se_. I call your attention to the last sentence in the manifesto:

    That is, while there is value in the items on the right, we value the items on the left more.
    
To adapt a popular adage, "_Plan_ long-term, _work_ short-term."
    
# Communication

I don't know many software engineers who entered the profession because they wanted to work with people. However, working with people is an absolute must in just about every profession. If we want the business to think long-term and make solid engineering choices we must learn to communicate with them.

The Responsibility of Communication is bi-directional. We must learn to communicate about estimates and risks. The Business must learn to consider risks as well as the cost. The Business should learn engineering concepts at a high-level (e.g., we can scale better if we use messaging). 

It's my observation that there often is a long-term plan but it is not necessarily communicated. As engineers, we must endeavor _to find out_ what it is. We must be honest when we think we are being pushed to make an engineering mistake. If we feel strongly about an option, we must become salesmen and _sell_ our perspective. 

# How do I Communicate with The Business?

I once had a product-owner come to me and ask for a feature. My team estimated 2 weeks to implement and test the new feature. He needed the feature in 3 days. He had some technical knowledge and offered a solution that might get the feature done faster. His solution would work, but it involved a lot of bad practices. We reached an agreement in which we would deliver the solution in 3 days using the hacky solution, but our next project would be to implement the feature correctly.

We were able to have this conversation because my team and I had a track record of delivering what was asked for in a working, bug-free state on a consistent basis. In other words, we had _trust_. It took some time to build that relationship of trust, but not as much as you might think. When I'm communicating with The Business about engineering alternatives, I make sure I answer 3 questions.

1. What problem are we trying to solve?
2. How long will each alternative take to deliver?
3. What are the risks associated with each alternative?

I make sure that The Business and I are in agreement on the answers to all 3 of these questions. Then I _accept_ their decision.


# What if They are Still Myopic?

If you're sure you've done everything you can to communicate clearly about short vs. long-term options and risks and if The Business insists on always taking the short-term high-risk solution, then you might be forced to conclude that you don't like working for that particular business.

I hate saying it, but most of the companies I worked for in the early part of my career are places I would not go back to.  I started my career in Greenville, SC. The first company I truly enjoyed working for was in Washington DC. I ended up in Seattle, WA where I found a company that does embrace most of my values. Do we have problems? Absolutely. However, with reason and communication as our tools, we are addressing them.


[it is regarded as normal]: http://iextendable.com/2016/04/09/the-normalization-of-deviance/
[this talk]: https://vimeo.com/146928263
[Christin Gorman]: https://twitter.com/christingorman
[the manifesto]: http://agilemanifesto.org/
[No True Scotsman]: https://en.wikipedia.org/wiki/No_true_Scotsman