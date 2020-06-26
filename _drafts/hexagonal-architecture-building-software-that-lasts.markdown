---
layout: post
title: Hexagonal architecture, building software that lasts
permalink: /blog/hexagonal-architecture-building-software-that-lasts/
date: 2017-07-06 19:12:10
categories: Architecture
banner_image: "hexagonal-architecture/hexagonal-architecture.png"
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

## Layers and boundaries

We try to organize our application's code by using directory structures, layers and boundaries. These boundaries can be
clear but they can also be fuzzy. Having clear boundaries in our application helps us and others understand how the
application is working.

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
within your control like frameworks, ORM's or outside libraries. Code outside of your control can change when you update
these systems causing your code to break. Keeping them within Infrastructure makes dealing with this change easier. 

{% include image_caption.html imageurl="/images/posts/hexagonal-architecture/hexagonal-architecture.png" 
title="Layered Architecture" caption="Layered Architecture" %}


## Domain layer

The domain layer is the innermost layer and doesn't depend on the outer layers. It has the classes that make up the
business rules of the application. When you make use of DDD the domain layer can consist of the following classes:

- Aggregates
- Aggregate roots
- Entities
- Value objects
- Repositories (the interface, but not the implementation)
- Domain event classes
- Domain services
- Other domain related classes

The central layer is the domain layer. As can be seen in the image this layer has no outside dependencies. 

## Application layer

Can be a normal service layer
Can contain commands with command handlers

## Infrastructure layer

