---
layout: post
title: Push new project to an external bare git repository
permalink: /blog/push-new-project-to-an-external-bare-git-repository/
categories: Development Tools
date: 2011-02-16 10:44:02
featured: false
comments: true
---

Responsive web design (RWD) is a web design approach aimed at crafting sites to provide an optimal viewing experience—easy reading and navigation with a minimum of resizing, panning, and scrolling—across a wide range of devices (from mobile phones to desktop computer monitors).



<!--more-->



A site designed with RWD adapts the layout to the viewing environment by using fluid, proportion-based grids, flexible images,and CSS3 media queries, an extension of the @media rule.



* The fluid grid concept calls for page element sizing to be in relative units like percentages, rather than absolute units like pixels or points.



* Flexible images are also sized in relative units, so as to prevent them from displaying outside their containing element.



* Media queries allow the page to use different CSS style rules based on characteristics of the device the site is being displayed on, most commonly the width of the browser.



* Server-side components (RESS) in conjunction with client-side ones such as media queries can produce faster-loading sites for access over cellular networks and also deliver richer functionality/usability avoiding some of the pitfalls of device-side-only solutions.

Sometimes you need to start up your project. I never found a simple guide on how to push to a bare git repository so I'm writing this down as a note to myself.

{% highlight bash %}
git init
touch .gitignore
git add .gitignore
git commit -m "Initial commit"
git remote add origin /path/to/bare/repo
git push origin master
{% endhighlight %}

This will push your new changes to you external bare git repository
