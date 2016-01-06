---
layout: post
title: Dropdowns in Kohana
permalink: /blog/dropdowns-in-kohana/
date: 2009-10-02 14:36:04
categories: Kohana 2
comments: true
---
I began to get irritated that I always had write a foreach for the Dropdowns after the query. So I was thinking isn't there a more easier way to do it. First I wrote a helper to do it for me but It was clumsy in my opinion. Since I like nice clean applications I extended the Database_Driver class. The problem is that you need too add it directly to system because you can't write it in app.

<!--more-->

Therefore you will need to add the following code in "\system\libraries\drivers\Database.php":

{% highlight php %}
public function select_list($id, $descriptor)
{ 
	$array = array();
	$result = $this;

	foreach ($result as $key=>$value)
	{ 
		$array[$value->$id] = $value->$descriptor;
	}

	return $array; 
}
{% endhighlight %}

After you did this you can use it like this:

{% highlight php %}
$user_model = new User_Model;
$users = $user_model->read_users()->select_list('user_id', 'user_name'); 
print form::dropdown('users', $users);
{% endhighlight %}
