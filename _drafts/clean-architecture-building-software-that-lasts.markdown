---
layout: post
title: Clean architecture, building software that lasts
permalink: /blog/clean-architecture-building-software-that-lasts/
date: 2017-07-06 19:12:10
categories: Architecture
image: "/images/posts/clean-architecture/clean-architecture.png"
tags:
- Architecture
- Design
- Development
comments: true
---

When building software we sometimes have the need to build it in a way so it can for years. Some projects I've worked on was
software that was almost 10 years old. Within these 10 years a lot changes. For example language changes, framework
changes and libraries that need to be replaced. In these cases the software needs to be build in a way to handle change
with little impact.

<!--more-->

## Foreword

When designing applications I use these principles myself to make them last and allow for easy change. Because with
every project also design documentation is written I keep writing down these principles over and over again. I want to
use this blog series to share what I have learned from designing these application's and how these principles can help
you.

Please remember that there is no single way to design a application architecture. While these principles certainly help
feel free to adjust them if this fits your needs better (I know I do depending of the needs of my clients).

## Layers and boundaries

We try to organize our application's code by using directory structures, layers and boundaries. These boundaries can be
clear but they can also become fuzzy if we're not careful. Having clear boundaries in our application helps us and
others understand how the application is working.

I often split my application's into 3 mayor parts that each have their own purpose. These 3 layers have really different
goals and structure's what makes them easy to keep them apart:

```
src/
    Domain/
    Application/
    Infrastructure/
```

Below is an illustration of the layers with their boundaries. The arrows show the direction of the dependencies.

### Dependency Direction

The direction of the dependencies of the architecture points inwards. This means that the domain only depends on code
that is within the domain. The application can depend on the code that is within the domain and application. At last the
infrastructure code can depend on any code and serves as the glue between the lower layers and outside systems like
frameworks, databases and libraries.

The reason this rule exists is to decouple your domain and application code from infrastructure code that is not always
within your control like frameworks, ORM's and libraries. Code that is outside of your control can change with updates
and keeping them within the infrastructure layer makes dealing with these changes easier.

This doesn't mean you can't use outside systems within you application or domain layer. To use these libraries within
these layers the application or domain layer needs to supply an interface that is implemented within the infrastructure
layer. This way the control of how systems communicate stays within the application or domain layer so you only have to
make changes in infrastructure.

{% include image_caption.html imageurl="/images/posts/clean-architecture/clean-architecture.png" 
title="Clean Architecture" caption="Clean Architecture" %}

## Domain layer

The domain layer is the innermost layer and doesn't depend on the outer layers. It has the classes that make up the
business rules of the application. When you make use of DDD the domain layer can consist of the following classes:

- Aggregates
- Aggregate roots
- Entities
- Value objects
- Domain repositories (the interface, but not the implementation)
- Domain event classes
- Domain services
- Other domain related classes

Together these classes decide on the business rules. Not having outside dependencies makes them really easy to unit 
test and the code really stable.

> While I said not to use outside libraries in domain code. I sometimes use extremely stable libraries that don't
> have outside dependencies. An example of a library is [Assert](https://github.com/beberlei/assert). I feel this is 
> perfectly fine in this case but do use outside libraries carefully.

## Application layer

The application layer could also be seen as the service layer of your application. It can contain service classes that
help with executing business rules on the aggregates in your domain layer. To do so it will load an aggregate from the
domain repository, run an operation on the aggregate and if the operation was successful persist the aggregate again. It
can also handle the collecting and dispatching of the domain events so other system can listen to these.

The only rule to keep here is that it only depends on code in the domain layer and itself. If communication with an
outside system is needed the application layer can supply an interface and dto's that can be implemented in the
infrastructure layer. This way the application layer stays in control of the protocol and can be tested without the
outside system. For testing the application layer you can either make use of unit tests or acceptance tests.

> There is no single way to build an application layer. You can make one of from service classes but you could also use
> commands and command handlers, usecase classes or any other pattern that fits your needs.

## Infrastructure layer

Most applications have to communicate with external systems like databases, message queue's and API's. These systems can
make the testing of you application very hard if you don't separate them from you application and domain layer.

The infrastructure layer has any code that handles for example the following tasks:

- Handing HTTP requests
- Talking to external API's
- Sending emails and notifications
- Persisting data in the database

Separating these things from your application layer and domain layer enables you to test these without these layers
present. For example you have an API client that communicates with a newsletter provider. Because the implementation is
separated from your application you will now be able to write integration tests for this library testing if it's
communicating with the provider properly.

#### Framework integrating code

Framework integrating code van also be found in the infrastructure layer. Most of these classes help with handling
client requests and rendering templates. But also the implementation of the repositories using the ORM libraries that
the framework supplies can be found in the infrastructure layer. Below is an example of a list of classes from
frameworks that you will find in the infrastructure layer.

- Controllers
- Repository Implementations (ORM)
- Forms
- Security classes

The advantage of separating these from the other layers becomes really apparent when you try to test these to see if
they integrate with the framework properly. You can integration test the controller if you want to by booting the
framework and requesting the controller you want to test.

### Advantages

There are a lot of advantages of having a clear separation between these layers. Not only makes it the code easier to
read but also easier to follow. Testability will improve because you can test all the layers separately. But there are
more advantages to using clearly separated layers. I will list them for you here:

- You can design the domain and the application layer without having to think about infrastructure like databases,
  frameworks and email systems.
- Upgrading frameworks, libraries and other infrastructural systems will only cause change in the Infrastructure layer
  keeping domain logic and application services intact.
- Switching around infrastructure systems and libraries becomes easier. Have a library that became deprecated? No
  worries just find another one to replace the deprecated one.
- Testability improves: You can write unit tests for your domain layer, acceptance tests for your application layer and
  integration tests for your infrastructure layer.

## Conclusion

I hope I gave a good insight in how to separate mayor concerns within your software. As you might have read at the
beginning of this blog post this is the first one of my blog series. The following blog post will take a deep dive into:

- How to design your domain layer
- How to build an application layer to run operations on your domain layer
- How to use the infrastructure layer to integrate with you framework, database and external systems

These blog posts will come with code samples showing the different part of the systems to give you a more cleared view.
