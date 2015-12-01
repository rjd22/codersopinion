---
layout: post
title: Porting a project from normal php to MVC
permalink: /blog/porting-a-project-from-normal-php-to-mvc/
date: 2010-05-10 17:18:19
categories: Development
comments: true
---

I've been working on a project for quite a while. It needed to be extended heavily. The designer before me had made his own kind of MVC system with smarty and OOP. Still the application had some huge structure and scaling issues. I'm going to talk about the process of migrating an existing application to Kohana (or any other MVC framework).</p>

# Phase 1: Structuring / Designing


## Finding the reason of the rewrite

Why are you going to rewrite the application. Just because MVC is so much better? If so you are wasting your boss his money. Migrations need to be thought trough. You could ask yourself the following questions to make sure you are making the right choice:

- Will the migration make the application more flexible for extension?
- Will it lessen the development time and money spend?
- Is the application big enough to be written in MVC?
- Doesn't the application contain functions that will break when you migrate it.
- (Do you have enough time / Is your boss patient enough) to rewrite your application.

If you answer these questions with a positive answer your application would be fit for migrations (note: This doesn't mean you HAVE to migrate it).

## Please think about structure and design

While some tend to start rewriting the application right off the bat, it's better to think about what your MVC application would look like when you're done. To to do this you will need to know what the current application consists of. Look at what code could be the controllers and how you are going to structure your views and models. You could make a chart with all object listed in a structured way.

<a href="http://www.dreu.info/wp-content/uploads/2010/05/example_talk.png"><img class="alignnone size-full wp-image-51" title="Example 1: Structuring" src="http://www.dreu.info/wp-content/uploads/2010/05/example_talk.png" alt="Example 1: Structuring" width="398" height="341" /></a>

This chart shows a way to structure your objects.

You could wonder why it's important to think about structuring before you start the migration. Some of you may think: "I'll just do it when I'm writing it". This is wrong. You should always think about how you are going to structure your application before you are going to write it. What would be the use of MVC if you aren't going to structure it correctly anyway.

## Deciding what tools to use

Before you are going to run off and write code it's important that you decide what libraries you are going to use. Like ORM, Auto Modeler standard Auth or Auth+ACL. These decisions need to be made before you start writing. If you find out that you need to switch in the middle you just burned a lot of time of your life and from your boss (I bet he won't be happy about that).

When you research about what libraries you are going to use you also need to consider (and please document !!!) how you are going to use them and for what purpose you are going to use them. Most applications fall on non-existent planning and documentation. By ruling out any changes you will avoid these troubles.

# Phase 2: Beginning migrating code

You now know what the application will look like when you're done. Now we should start with the migration. While some may think otherwise there are multiple approaches of migrating an application. Both have their pro's and con's so it's up to you how you're going to tackle your migration.

## Option 1: Full rewrite

This is the most time expensive way of migrating. You will check and rewrite most of the code. You can say the application will be completely different after this step. This method takes a lot of time but also gives the best quality code from the beginning. When writing for a boss or an external party you will have to explain that rewriting an application takes a lot of time and somehow they need to be satisfied with that answer.

### Pros:

- Clean High quality Code
- Good check for bugs and sometimes results in the fixing of many known bugs

### Cons:

- Takes a lot of time
- Needs a patient boss / client

## Option 2: MRR (Migrate Release Rewrite)
This is the method I like best. This method is just a copy paste job while structuring your application and rewriting only the needed parts. Porting you application will take a small amount of time. When completely finished you will release it to the public. Your boss/client will like the fast response and release. After the release you will start the rewrite. Slowly you will look for bloated code and update it while releasing multiple version that patch the production environment. This way your client / boss will see that the application is being improved and worked on and be more satisfied with the results.

### Pros:

- First release is fast.
- Boss / Client doesn't have to wait a long time for a release.

### Cons:

- The first release still contains all the bugs that the old application has.
- Past release rewrites could take a bit more time.

# Phase 3. Releasing? Or not

## Join the Dark side

At this point a lot of programmers tend to join the dark side (*coff coff*). They keep rewriting their sources and updating it without releasing it first. While I agree with the reasoning that the first release should be good your boss won't. Even if the application is not completely done its best to release a early alpha/beta version. While not finished your users may find bugs that you won't find.

## Fixing filed bugs

While you are getting bug reports you start fixing the blocking bugs. Making small updates to the production environment and notifying users that the bug they found has been fixed (they even may start to think that you might be useful after all, and <span style="text-decoration: underline;">not</span> lazy). The users can see that the application is moving forward while you are motivated to update it.

# Phase 4. Rewrite

## Bloated code

Rewriting applications might be a difficult and nerve-whacking job it's still the one that is needed the most. Doesn't it make you cry that you feel the need to post multiple snippets of source to theDailyWTF (that are all from the same application). Well by rewriting them we are going to make sure that won't happen again and extending it will be a breeze (note to self: make sure your code doesn't end up at theDailyWTF). Don't just write code think it trough.

## Questions to ask yourself
Some questions you might want to ask yourself when writing:

- Am I going to use this variable more than once?
- Why do I keep pushing ctrl+c?
- Can't I make this an independent function?
- Should I put everything in one class?
- Where does my validation go?
- Where does my authorization go?
- Where do my data + structuring go?
- Can't I just post trough a single variable?
- What should or shouldn't I do in my views

While I have a bigger list ;), these would be the main points interest.

## Communicate

It's important that you have a clear view of the structuring that you will use for your application. If you don't know how to structure your application talk to other developers. They can point you in the right direction. If you aren't sure just ask for arguments and reasons why they choose for their approach. Some of them might have thought a lot about the problem you now facing and come to a conclusion that worked best for them.

# Phase 5. Issues

Most likely this will be the most interesting part of this talk. When you plan and document right, you shouldn't run into any problems but it doesn't completely prevent them. This part of the article will talk about the problems I ran into because of insufficient checking and testing.

## Different behavior between production and development environment

This might be the most common issues around when migrating. While the previous application just ran fine and the new one doesn't. Most likely the differences in the PHP or MySQL version causes this to occur but it could be something completely unexpected and hard to trace like differences in modules and configuration.

## Finding out that you are doing it wrong when you are almost done

I really hate it when this occurs. When I find out that I was doing it completely wrong. And if I would change it, it would cost me a lot less time in the future. I tend to ignore this when it's not blocking. I note it down in my bug tracker and finish and release the application. After releasing I start to rewrite it and delete all my quick fixes that I did before. Maybe a useful tip. I tend to add a comment to a quick fix, like:

<blockquote>//todo: Delete this quick fix after rewrite</blockquote>

When I comment it like this I can track down the bad code and update it fast. When the issue is blocking(you can't fix it without the rewrite) you don't have much of a choice so just start rewriting (sorry no useful tips here).

## Breaking stuff that once worked

This will happen to everyone. When migrating code stuff breaks. It happens because of missing libraries or functions that are positioned and loaded somewhere else. You can prevent this with testing everything what a user does within the application, checking the calculations and output it throws at you. Sometimes broken stuff doesn't throw an error at you and could generate incorrect information that the user is counting on. Since the user things that even after the migration the values are correct it won't doubt and double check them.

If this might occur anyway, patch the bug the same day so that it won't influence any company processes.
