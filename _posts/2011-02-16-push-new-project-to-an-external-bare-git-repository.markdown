---
layout: post
title: Push new project to an external bare git repository
permalink: /blog/push-new-project-to-an-external-bare-git-repository/
categories: Development Tools
date: 2011-02-16 10:44:02
comments: true
---

Sometimes you need to start up your project. I never found a simple guide on how to push to a bare git repository so I'm writing this down as a note to myself.

<!--more-->

{% highlight bash %}
git init
touch .gitignore
git add .gitignore
git commit -m "Initial commit"
git remote add origin /path/to/bare/repo
git push origin master
{% endhighlight %}

This will push your new changes to you external bare git repository
