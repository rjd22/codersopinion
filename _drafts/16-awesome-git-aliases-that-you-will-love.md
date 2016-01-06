---
layout: post
title: 16 awesome git aliases that you will love
permalink: /blog/16-awesome-git-aliases-that-you-will-love/
date: 2015-12-11 14:02:00
categories: Development Tools
comments: true
---

Using git has completely integrated itself into the development workflow. It is a extremely powerful tool for managing
your source code. It has also proven itself as a great review, OTAP and deployment tool.

When using git in the CLI you will have to write a lot of long commands to get things done. Most commands are simple but 
some of them are quite complex and bothersome to type. Since we developers are of course taught to be lazy (for the sake of being the stereotype),
and to write as little as possible.

Because the above applies to me, I use git aliases to shorten my git commands that I use most, and improve the information
they return. In this blog post I will give a list of simple but powerful aliases that you might grow to depend on an love.

# Simple git aliases for commands that most of us use regularly

Some git aliases are really straightforward, they just replace the original command and are meant to make you write less.
Here is a list of these aliases:

{% highlight ini %}
co = checkout       # Checkout a branch
cob = checkout -b   # Checkout a new not yet existing branch
f = fetch -p        # Fetch from a repository and prune any remote-tracking references that no longer exist on the remote.
c = commit          # Commit you changes
p = push            # Push you changes to a remote
ba = branch -a      # List both remote-tracking branches and local branches.
bd = branch -d      # Delete a branch only if it has been merged
bD = branch -D      # Force delete a branch
dc = diff --cached  # Display the staged changes
{% endhighlight %}

## Checking the status of your git commit

Checking the status of the commit you're working on belongs to the daily routine of most developers. We make changes to
something we check what files we changed before staging our changes to see if we didn't change a file that we were not
supposed to change.

Making the command shorter while trying to make it more concise will make typing the command less of a hassle.

alias: `st = status -sb`
result:
![Checking the status of you git commit]({{ site.url }}/assets/awesome-git-aliases/git-st.png)

## Stage your git changes in patches

I really like to review my changes before adding them, maybe you do too. Git diff is a really good tool for this, but
what if you only want to add parts from the changes you made, so you can spread them over multiple commits, or if you
want to review every small step.

In this case `git add -p` comes to our rescue!

alias: `a = add -p`
result:
![Staging your git changes in patches]({{ site.url }}/assets/awesome-git-aliases/git-a.png)

## More informational git logs

Git logs help us to see what happened to the code we're working on. They are a history of the changes made but also when
it was branched and when that branch has been merged back. When we [write good commit messages](http://chris.beams.io/posts/git-commit/)
the git log becomes an extremely important tool to see the changes made to the code and why these changes were made.

Improving the output of the git log will make it easier to spot these changes.

alias: `plog = log --graph --pretty='format:%C(red)%d%C(reset) %C(yellow)%h%C(reset) %ar %C(green)%aN%C(reset) %s'`
result:
![Git log the pretty way]({{ site.url }}/assets/awesome-git-aliases/git-plog.png)

alias: `lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit`
result:
![Git log the pretty way 2]({{ site.url }}/assets/awesome-git-aliases/git-lg.png)

alias: `tlog = log --stat --since='1 Day Ago' --graph --pretty=oneline --abbrev-commit --date=relative`
result:
![Git log with the files that changed for each commit]({{ site.url }}/assets/awesome-git-aliases/git-plog.png)

## Who works on a project ordered by number of merges

Finding out the top contributors of the project can come in handy when you want to find out who to speak to when you
have a question. Or it is just a plain fun tool who is working the "hardest" ;).

alias: `rank = shortlog -sn --no-merges`
result:
![Who works on a project ordered by number of merges]({{ site.url }}/assets/awesome-git-aliases/git-rank.png)

## Remove all branches merged into your current branch

Before making a pull-request we need to make a branch locally where we can commit our work to. After a while you will 
end up with a lot of branches that are already finished and merged into you master branch. Deleting these one by one can
be a real hassle.

When these merged branches become big in number, deleting all those with a single command becomes really handy.

alias: `bdm = "!git branch --merged | grep -v '*' | xargs -n 1 git branch -d"`
result:
![Remove all branches merged into your current branch]({{ site.url }}/assets/awesome-git-aliases/git-bdm.png)

{% highlight ini %}
[alias]
    # Shortening aliases
    co = checkout
    cob = checkout -b
    f = fetch -p
    c = commit
    p = push
    ba = branch -a
    bd = branch -d
    bD = branch -D
    dc = diff --cached

    # Feature improving aliases
    st = status -sb
    a = add -p

    # Complex aliases
    plog = log --graph --pretty='format:%C(red)%d%C(reset) %C(yellow)%h%C(reset) %ar %C(green)%aN%C(reset) %s'
    tlog = log --stat --since='1 Day Ago' --graph --pretty=oneline --abbrev-commit --date=relative
    lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
    rank = shortlog -sn --no-merges
    bdm = "!git branch --merged | grep -v '*' | xargs -n 1 git branch -d"
{% endhighlight %}
