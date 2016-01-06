---
layout: post
title: Using Jquery serialize with php
permalink: /blog/using-jquery-serialize-with-php/
date: 2009-10-05 15:20:22
categories: PHP Development
comments: true
---

When making forms ever had the urge to find something easier than having to define every value in your JavaScript? I did and found something nice called serialize. What is does is add all values into 1 string. Because I began to like serialize I'm writing an article on the use of it.

<!--more-->

Lately I see a lot of people writing their own functions to deserialize it in php not knowing that php has it's own function for deserializing namely 'parse_str'. What it does is get the values and put them into an array so you can access them individually. Here is a little code for example:

# This is the Template
{% highlight html %}
<script type="text/javascript">
	function refresh(data) {
		$('#result').html(data);
	}
	$(document).ready(function(){
		$("#search").click(function(){
			var search = $("#searchform").serialize();
			var url = 'search.php';
			$.post(url, search, refresh, "html");
		});
	});
</script>
<form id="searchform">
	<table>
		<tbody>
		<tr>
			<td>Name:</td>
			<td><input type="text" name="name" size="30" /></td>
		</tr>
		<tr>
			<td>Surname:</td>
			<td><input type="text" name="surname" size="30" /></td>
		</tr>
		<tr>
			<td>E-mail address:</td>
			<td><input type="text" name="email" size="30" /></td>
		</tr>
		</tbody>
	</table>
	<input id="search" type="button" value="Search" />
</form>
{% endhighlight %}

This is the php handler (search.php)

{% highlight php %}
//Unserialize string to array
$searchserialized = $_POST['search'];

parse_str($searchserialized, $searcharray);

$name = $searcharray['name'];
$surname = $searcharray['surname'];
$email = $searcharray['email'];

echo $name.'-'.$surname.'-'.$email;
{% endhighlight %}

Man it's so easy to use serialize
