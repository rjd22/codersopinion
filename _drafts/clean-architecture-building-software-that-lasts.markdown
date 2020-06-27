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

When building software we sometimes have the need to build so it can for years. Some projects I've worked on was 
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

- Domain
- Application
- Infrastructure

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
outside system.

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

### Framework integrating code

All framework integrating code van also be found in the infrastructure layer. Most of these classes help with handling
client requests and rendering templates. But also the implementation of the repositories using the ORM libraries that
the framework supplies can be found in the infrastructure layer. Below is a list of classes from frameworks that you 
can find in a infrastructure layer.

- Controllers
- Repository Implementations (ORM)
- Forms
- Security classes

## Conclusion

