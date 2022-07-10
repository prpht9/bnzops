# Bias

Definition:

1. an inclination of temperment or outlook
2. an instance of such prejudice

Being that "bias" in our case is "an instance of prejudice". We acknowledge significant "pre judging" of certain solutions which we have found to be significantly lacking in the ability to scale and still retain high marks in confidentiality, integrity and availability. Anti-patterns are hard to avoid when you haven't experienced them. Our intent is to avoid these by proposing a few strategies which are bias towards avoiding anti-patterns and acheiving a quality much higher than most can accomplish when designing solutions without significant peer review and experience with their advantages and failings.

To be forthright, and very specific about our views on bias. We do not condone prejudice against anyone for their race, religion, culture or any other aspect. k8s clusters and network designs have no such feelings which can be hurt by these views. Period, end of discussion.

# What is Bias Near Zero Ops

Zero Ops and No Ops are fairly new concepts which attempt to empower development teams by removing a lot of operational tasks. This is a great step forward but tends to fall slightly short when implementing in larger enterprises or busisnesses with unique requirements which need special configurations or features which are not provided with standard Cloud Services. Some examples of this might be special encryption capablities in your data tier, existing in both on-premise and cloud infrastructure or security requirements not met by Cloud Services.

This is where simple Bias can save the day. If you can't completely remove all your operations then how to you reduce it to the point where you can gain all the benefits of being Agile with DevOps while getting as close to Zero Ops as you can and still meet the complex requirements of todays businesses. Let the experts who have been doing this for decades design and build an architecture and solution which is capable of solving 90% of your situations with Zero Ops and makes it really simple to solve the other 10% of the situations without breaking the model enabling the other 90%. This is they key to maintaining the majority of your operations near zero.

# Here is the hard part

Bridgine the gap between DevOps and ZeroOps. How to get from one to the other and keep your teams from destroying the magic which binds them together.  Bias.

Years ago there was a major shift in how web applications were written across multiple languages. This shift was from writing all the code yourself to adopting a web application framework like Spring for Java, Ruby on Rails or Django for Python. These included concepts like a Model/View/Controller (MVC) pattern, a templating engine, caching and some form of Object Relational Mapping (ORM) solution. But these are not the keys to solving our problem.

Our problem is a bit more subtle but seriously beneficial and used by every single one of the frameworks... conventions. Some of them are naming conventions, some of them are layout conventions and others are framework conventions.  These are where we will focus our "Bias". Experience has taught us these conventions can do way more than just speed up development cycles. They can also protect teams from creating more operational work than necessary when having to deviate from Zero Ops solutions. If we take this one step further and have a few biases, maybe we can avoid anti-patterns and faciliate better velocity for our infrastructure and development teams while keeping our overhead very low for things like PCI Audits and fault tolerance. Bias examples:

* Multi-az deployments
* Hub and spoke networks
* Bastion/Jump hosts
* Three tier subnet design
* Consolidated logging in shared network spoke
* Single solution for metrics, visualization, alerting and escalation

The goal of this project is to provide an open source project where we can discuss the main strategies of implementation where we can help guide DevOps teams on how to build infrastructure whos "conventions" protect them from the dangers of making everything different.  If you stay within reasonable conventions, you can practically elimenate most of your operational overhead.

DevOps is one of the most revolutionary concepts in IT since the Agile Movement started. Recently the concept of "No Ops" or "Zero Ops" has come into being. Where it attempts to provide Platform as a Service (PaaS) to development groups so they can move forward with new projects, getting through the hurdles of build, release, deployment without having to do much operations whatsoever.


