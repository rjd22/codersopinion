---
layout: post
title: Clean architecture, building software that lasts
permalink: /blog/clean-architecture-building-software-that-lasts/
date: 2020-06-28 11:08:00
categories: Architecture
image: "/images/posts/clean-architecture/clean-architecture.png"
tags:
- Architecture
- Design
- Development
comments: true
---

When building software we sometimes need to build it in a way so it will last for years. Some projects I've worked on
used software that was running for almost 10 years. Within these 10 years, the software had experienced many changes. 
For example language changes, framework changes, libraries that need to be replaced, and many more. When this is the 
case, software needs to be built in a way to account for those many changes with little impact.

<!--more-->

## Foreword

When designing application architectures I often use these principles myself to make the software last and allow for
easy change. With every project, I also write design documentation with these principles in them and thus have written
them down quite some times already. The goal of these blog series is to share what I have learned when designing these
application architectures and hopefully they can also help you.

Please remember that there is no single way to design an application architecture. These principles certainly help but
feel free to adjust them when this fits your needs better (I know I do, depending on the needs of my clients).

## Layers and boundaries

We try to organize our application's code by using directory structures, layers, and boundaries. These boundaries can be
clear at first but sometimes they become fuzzy if we're not careful. Having clear boundaries in our application helps us
and others understand how the application is working.

I often split my application into 3 major parts, each having their own purpose. The goals and structure of each part is
different, making it easy to keep them apart:

```
src/
    Domain/
    Application/
    Infrastructure/
```

Further below is an illustration of the layers with their boundaries. The arrows show the direction of the dependencies.

### Dependency Direction

The direction of the dependencies of the architecture points inwards. This means that the domain only depends on the
code that is within the domain. The application can depend on the code that is within the domain and application, and 
the infrastructure code can depend on any code. It serves as the glue between the lower layers and outside systems
for example frameworks, databases, and libraries.

The reason this rule exists is because outside systems are not always within your control, and can change with updates.
Keeping this code within the infrastructure layer makes it easier to deal with these changes.

This doesn't mean you can't use outside systems within your application or domain layer. To use these libraries within
these layers the application or domain layer needs to supply an interface that is implemented within the infrastructure
layer. This way the control of how these systems communicate stays within the application or domain layer and you only
have to make changes in infrastructure.

{% include image_caption.html imageurl="/images/posts/clean-architecture/clean-architecture.png" 
title="Clean Architecture" caption="Clean Architecture" %}

## Domain layer

The domain layer is the innermost layer and doesn't depend on the outer layers. It has the classes that make up the
business rules of the application. When you make use of for example
[Domain Driven Design](https://dddcommunity.org/library/vernon_2011/) the domain layer can consist of the following
classes:

- Aggregates
- Aggregate roots
- Entities
- Value objects
- Domain repositories (the interface, but not the implementation)
- Domain event classes
- Domain services
- Other domain-related classes

Together these classes decide on the business rules. Not having outside dependencies makes them easy to unit-test and
improves the stability of the code.

> While I earlier wrote not to use outside libraries in domain code, sometimes I use extremely stable libraries that
> don't have outside dependencies themselves. An example of a library is [Assert](https://github.com/beberlei/assert).
> I feel this is perfectly fine in some of these cases, but do use outside libraries carefully.

## Application layer

The application layer could also be seen as the service layer of your application. It can contain service classes that
help with executing business rules on aggregates in your domain layer. It will load an aggregate from the domain
repository, run an operation on the aggregate, and if the operation was successful, persist the aggregate again. The
application layer can also handle the collecting and dispatching of domain events so other systems can listen in on the
changes that have happened in your domain.

The only rule to keep here is that the application code only depends on code in the domain and application layer. If
communication with an outside system is needed the application layer can supply an interface and DTO objects that can
be implemented in the infrastructure layer. By doing so the application layer stays in control of the protocol and can
be tested without the outside systems present. If you want to test the application layer you can either make use of unit
or acceptance tests.

> There is no single way to build an application layer. You can make one of from service classes but you could also use
> commands and command handlers, use-case classes, or any other pattern that fits your needs.

## Infrastructure layer

Most applications have to communicate with external systems like databases, message queues, APIs, and so on. These
systems can make testing your application and domain layer very hard if you don't separate them properly from these
layers.

The infrastructure layer has any code that handles as an example, the following tasks:

- Handling HTTP requests
- Talking to external API's
- Sending emails and notifications
- Persisting data in the database
- And many more...

Separating these tasks from your domain and application layer enables you to write integration tests for them without
the need of having the domain and application layer present.

For example, when you have an API client that communicates with a newsletter provider. Because the implementation is
separated, tests can be written to test only the communication with the external provider without having to run the
code in the domain and application layer.

#### Framework integrating code

Framework integrating code can also be found in the infrastructure layer. Most of these classes help with handling
client requests and rendering templates. But also the implementation of repositories that are using the ORM library that
is supplied by the framework can be found in the infrastructure layer. Below is an example of a list of classes from
frameworks that you will most likely find in the infrastructure layer.

- Controllers
- Repository Implementations (ORM)
- Forms
- Security classes

The advantage of separating these from the other layers becomes apparent when you try to test these to see if
they integrate with the framework properly. You can write integration tests for the controllers by booting the
framework and requesting the controller you want to test.

### Advantages

There are many advantages to having a clear separation between these layers. Not only will the code be easier to
read but also easier to follow. Testability will improve because you can test the layers separately. But there are
more advantages to using separated layers. I will list them for you here:

- You can design the domain and the application layer without having to think about infrastructures like databases,
  frameworks, and email systems.
- Upgrading frameworks, libraries, and other infrastructural systems will only cause a change in the Infrastructure
  layer keeping domain logic and application services intact.
- Switching around infrastructure systems and libraries becomes easier. Have a library that became deprecated? No
  worries just find another one to replace the deprecated library.
- Testability improves: You can write unit tests for your domain layer, acceptance tests for your application layer, and
  integration tests for your infrastructure layer.

## Conclusion

I hope this blog post gave you a good insight into how to separate major concerns within your software. As you might have
read at the beginning of this blog post, this will be the first one of my blog series. The following blog posts will take
a deep dive into:

- How to design your domain layer
- How to build an application layer to run operations on your domain layer
- How to use the infrastructure layer to integrate with your framework, databases, and external systems

These blog posts will come with code samples showing the different parts of the systems to give you a more clear view.
