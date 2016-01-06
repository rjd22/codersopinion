---
layout: post
title: CSS3 owns IE not
permalink: /blog/css3-owns-ie-not/
date: 2009-11-05 16:52:58
categories: Front-End Development
comments: true
---

Lately I've been looking for nice simple fixes for common problems inside styling your application. I've began to notice that CSS3 implements a lot features that I was looking for, to find out later that Microsoft is being stubborn again to implement it right(if they do it at all).

<!--more-->

Likely most web developers feel this but when you run your application in IE a little part inside of you dies. Since I don't want to take the focus to Microsoft (I only make a exception if it's bad for Microsoft's sales) I'm going to continue with CSS3.

CSS3 has great new features that make your life of a web developer a lot easier. You almost could say that we're getting spoiled don't you think? I'm going to talk about 2 of the most popular functions:</p>

1. Even and Odd Rows
2. Rounded Corners

# Even and Odd Rows

Alway noticed that you had to make a script to be able to style even and odd Rows? I bet you did. I hated making it because it acctually was a tiny bit of useless(ugly) code inside your template. CSS3 will fix this for you. With CSS3 you just use the next CSS code and it will style your rows on odd or even count without having to code anything inside your template:

{% highlight css %}
tr:nth-child(even) { 
	background: #CCCCCC; 
} 

tr:nth-child(odd) { 
	background: #FFFFFF; 
}
{% endhighlight %}

This tiny code makes your even rows grey and your odd rows white. Can't be easier can it?

# Rounded Corners

Back in the time we used images to make our corners round. At that time we didn't have anything else. Now we can use "border-radius" a fix to this. By setting the amount of pixels we can make our corner more or less round:

{% highlight css %}
-moz-border-radius: 6px;
-webkit-border-radius: 6px;
border: 1px #CCC solid;
{% endhighlight %}

This were the features of CSS3 I really liked. Lets hope they will be in all browsers soon. (or that everyone stops using IE ;) )
