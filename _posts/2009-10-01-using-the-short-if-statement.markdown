---
layout: post
title: Using the short if statement
permalink: /blog/using-the-short-if-statement/
date: 2009-10-01 14:01:45
categories: PHP Development
comments: true
---

I'm always lost when I need to find the shorthand version of the if statement in php. That is why I write again a small note for myself so I can find it again.

{% highlight php %}
$value = 'sunny';
$weather = ($value == 'sunny')
    ? "It is a sunny day"
    : "Stay in bed its raining";

echo $weather;
{% endhighlight %}

There are multiple implementations for the short tag but this is the one I use the most. Maybe I document others too when I feel like it.
