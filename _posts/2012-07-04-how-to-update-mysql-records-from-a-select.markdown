---
layout: post
title: How to update mysql records from a select
permalink: /blog/how-to-update-mysql-records-from-a-select/
date: 2012-07-04 13:31:15
categories: Database Management
comments: true
---

While I was working on a project I needed to migrate some information from one table to the other. But only specific data. I was looking for a solution but I only found one easily for a mssql database. After some research I found a way to copy data from one to an other table while using where to filter:

<!--more-->

{% highlight sql %}
UPDATE table1 tb1
INNER JOIN table2 tb2
ON tb1.id = tb2.sub_id
SET
tb1.field = tb2.field
WHERE tb1.field = ''
{% endhighlight %}

With this query you can easily transfer data from table2 to table1
