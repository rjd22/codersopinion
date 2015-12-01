---
layout: post
title: Using Smarty in Kohana
permalink: /blog/using-smarty-in-kohana/
date: 2009-10-01 14:52:15
categories: Template Engines
comments: true
---

Oh god why would you use smarty in kohana!! I know it's bad. My boss wants me to use smarty in kohana so I'm granting his wish. Still I don't like doing it. Anyway while I'm at it why not use my time to write a article on how to use it.

<!--more-->

A person with the nickname d9 made a nice implementation of Kohana with Smarty using the normal template methods. So no writing smarty assigns in your controller wohoo!!

I uploaded it to my own server for bandwidth sake so here it is:

<a href="http://www.dreu.info/wp-content/uploads/2009/10/kohana2.3.3_smarty2.6.22.zip">kohana2.3.3_smarty2.6.22</a>

Well back to basics. Lets first write the model that gets some values from the database. Since you all can guess how the database will look I'm not going to post a query script.

# The model (user.php):

As you can see its the same as the standard models of kohana nothing different on it. In the controller we will do 1 thing a bit different but other than that it will be the same (user.php):

{% highlight php %}
class User_Controller extends Global_Controller {
	public function index()
	{
		$user_model = new User_Model;

		// standard kohana way
		$users = $user_model->read_users();

		// smarty way
		$users = $user_model->read_users()->result(FALSE);

		$this->view = new View('user/index');
		$this->view->users = $users;
		$this->template->content = $this->view;
	}
}
{% endhighlight %}

I posted how I would do it normally and how I do it with smarty next to each other. As you can see a rule is added namely "result(FALSE)" because of this the result will be returned as a array in place of a object so that smarty can parse trough it. Also a comment on the Global_Controller I extend that is just a controller that contains my database connection and the global template namely "$template".

Now as last lets show you the template namely (user/index.tpl) and see how smarty goes in its work:

{% highlight smarty %}
{foreach from=$users key="k" item="report"}
<table border="0">
	<tbody>
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Address</th>
			<th>City</th>
		</tr>
		<tr>
			<td>{$report.id}</td>
			<td>{$report.name}</td>
			<td>{$report.address}</td>
			<td>{$report.city}</td>
		</tr>
	</tbody>
</table>
{/foreach}
{% endhighlight %}

That is all you need to know. Easy isn't it? Btw I still hate smarty implementations in kohana but it works.

<strong>EDIT:</strong>
Someone also released a smarty plugin for kohana3 look here: <a href="https://github.com/MrAnchovy/kohana-module-smarty/wiki">https://github.com/MrAnchovy/kohana-module-smarty/wiki</a></p>
