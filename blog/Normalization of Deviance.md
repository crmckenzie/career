# Normalization of Deviance

The Normalization of Deviance is a concept that 

    describes a situation in which an unacceptable practice has gone on for so long without 
    a serious problem or disaster that this deviant practice actually becomes the 
    accepted way of doing things. 

[challenger explosion]
    

You're familiar with this concept already. You've encountered everytime you've seen someone doing 
they know to be wrong but justifying it with "we've never had a problem before." This is the 
person (myself in my younger years) who consistently buys things s/he can't afford with credit
cards. This is the person goes out drinking and drives home. This is the software engineer who
writes code without tests. This is the business that ignores through continual deferment
technical debt issues raised by its engineers.

As software engineers, we know we should remove dead code in projects. We know 
that we should automate software deployment. We know we should provide reliable automated tests
for our features. We know we should build and test our software on a machine other than our
personal dev box. We know that we should test our software in a prod-like environment that
is not prod.

Do you do these things in your daily work? Does your organization support your efforts?

## How do you identify the Normalization of Deviance?

One of the challenges you will face identifying Normalization of Deviance is the fact that
things you do on a daily basis are... _normal_.

There are several "smells" that could indicate that your organization has succumbed to the
Normalization of Deviance.
* You have "official" policies that do not describe how you actually do work.
* You have automation that routinely fails and requires handholding to reach success.
* You have unit or integration tests that fail constantly or intermittently such that your team
does not regard their failure as a "real" problem.
* You have difficult personalities in key positions who turn conversations about their effectiveness
into conversations about your communication style.

All of these issues are "of a kind," meaning that they are all examples of _routinely accepted 
failure_. This is obviously not an exhaustive list.

## Why is it a problem?

You will eventually have a catastrophic failure. Catastrophic failures seldom occur in a vacuum. 
Usually there are a
host of seemingly unrelated smaller problems that part of daily life. Catastrophic failure 
usually occur when the stars align and the smaller issues coalesce in such a way that some
threat vector is allowed to completely wreck a process. This is known as the [Swiss Cheese Model]
of failure.  I first learned about the Swiss Cheese Model in a book called [The Digital Doctor], 
which is a holistic view of the positive and negative effects of software in the medical world.
This book is well-worth reading.

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=qf_sp_asin_til&ad_type=product_link&tracking_id=iextendableco-20&marketplace=amazon&region=US&placement=0071849467&asins=0071849467&linkId=OH4TRSCNZ4LJ6AJQ&show_border=true&link_opens_in_new_window=true">
</iframe>


A fascinating case of software failure that destroyed a company overnight is the story of [Knight Capital].
In a writeup, Doug Seven lays the blame at the lack of an automted deployment system. I agree,
though I think the problems started much, much earlier. Doug writes:

    The update to SMARS was intended to replace old, unused code referred to as “Power Peg” – 
    functionality that Knight hadn’t used in 8-years (why code that had been dead for 
    8-years was still present in the code base is a mystery, but that’s not the point). 

It's *my* point. The Knight Capital failure began 8 years before when dead code was left
in the system.  I've had conversations with The Business where I've tried to justify removing
dead code. It's hard to make them understand what the danger is.  "It's not hurting anything is
it? It hasn't been a problem so far has it?" No, but it will be.

The second nail in Knight Capital's coffin was that they chose to repurpose an old flag that
had been used to activate the old functionality.  As Doug Seven writes:

    The code was thoroughly tested and proven to work correctly and reliably.
    What could possibly go wrong?

Indeed.

The final nail is that Knight Capital used a manual deployment process. They were to deploy
the new software to 8 servers. The deployment technician missed one. I don't actually know this,
but I can just imagine the technician staying after-hours to do the upgrade and wanting nothing
more than to go home to his/her family or happy-hour or something.

    At 9:30 AM Eastern Time on August 1, 2012 the markets opened and Knight began processing 
    orders from broker-dealers on behalf of their customers for the new Retail Liquidity 
    Program. The seven (7) servers that had the correct SMARS deployment began processing 
    these orders correctly. Orders sent to the eighth server triggered the supposable 
    repurposed flag and brought back from the dead the old Power Peg code.

There were more issues during their attempt to fix the problem, but none of it would have happened
except that these 3 seemingly minor problems coalesced into a perfect storm of failure. 
The end result?

    Knight Capital Group realized a $460 million loss in 45-minutes... Knight only 
    has $365 million in cash and equivalents. In 45-minutes Knight went from being the 
    largest trader in US equities and a major market maker in the NYSE and NASDAQ to bankrupt.

## How do you fix it?

I'm still figuring that out. Luckly, Redacted Inc doesn't have too many of these sorts
of problems so my opportunities for practice are few, but here are my thoughts so far.

The biggest challenge in these scenarios is that people are so used to accepting annoying or
unreliable processes as normal that they cease to see them as daily failure. It's not until 
after disaster has struck that it's clear that accepted processes were in fact failures.
Nobody at Knight Capital was thinking "jeez, that dead code is really hurting us."

There's an old management adage: "You can't manage what you can't measure." You can start
addressing NOD issues by identifying risky patterns and practices that your organization uses
in its daily standard operating procedure. If you can find a way, assign a cost to them. 
Consider ways in which these normal failures could align to cause catastrophy. If you 
have a sympathetic ear in management, start talking to them about this. Introduce 
your manager to these concepts. Tell them about [Knight Capital]. Your goal is to get management
and The Business to see the failures for what they are. By measuring the risks and costs to
your organization of acceptable failure you will have an easier time getting your voice heard.

Most importantly, come up with a plan to address the issues. It's not enough to say "this is a
problem." You need to say "This is a problem and here are some solutions." Go further still, show
how you get your team from "here" to "there." Try to design solutions that make the day to day
work _easier_, not harder. Jeff Atwood calls this the [Pit of Success]. His blog scopes this 
concept to code, but it applies to processes as well. You want your team to "fall into" the 
right way to do things.

Another potential source of positive feed back are new members to your team. It may be hard
to get them to open up for fear of crossing the wrong person, but they are new to your organization
and they will see more clearly the things that look like failures waiting to happen. _Nothing
you are doing is normal to them yet._


[challenger explosion]: http://smartblogs.com/leadership/2014/10/24/the-normalization-of-deviance-when-saying-weve-never-had-problems-before-becomes-a-problem/
[Knight Capital]: http://dougseven.com/2014/04/17/knightmare-a-devops-cautionary-tale/
[Pit of Success]: http://blog.codinghorror.com/falling-into-the-pit-of-success/
[Swiss Cheese Model]: https://en.wikipedia.org/wiki/Swiss_cheese_model
[The Digital Doctor]: http://www.amazon.com/gp/product/0071849467/ref=as_li_tl?ie=UTF8&camp=1789&creative=9325&creativeASIN=0071849467&linkCode=as2&tag=iextendableco-20&linkId=HBD2AV2RULWYHMWS

