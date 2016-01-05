---
layout: post
title: 16 awesome git aliases that you will love
permalink: /blog/16-awesome-git-aliases-that-you-will-love/
date: 2015-12-11 14:02:00
categories: Development Tools
comments: true
---

Using git has completely integrated itself into the development workflow. It is a extremely powerful tool for managing
your code. It has also proven itself as a great review, OTAP and deployment tool.

When using git in the CLI you will have to type a lot to get things done. Some commands are simple but others can be
quite complex and bothersome to type. Since we developers are born lazy (for the sake of applying the stereotype) we
rather type less than more.

Since this is the case I use git aliases to shorten the commands I use most of the time and improve the information
these commands usually give to me. In the rest of this blog post I will give a list if simple but also powerful aliases
that you will grow on you and that you will love.

# Simple git aliases for commands that most of us use regularly

Some git aliases are really straightforward they use serve to make you type less in your console. Here is a list of
replacement aliases:

{% highlight bash %}
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

alias: `st = status -sb`
result:
![Checking the status of you git commit]({{ site.url }}/assets/awesome-git-aliases/git-st.png)

## Stage your git changes in patches

Most of us like to review our changes before adding them. Git diff is a really good tool for this but what if you only
want to add parts from the changes you made so you can spread them over multiple commits or if you want to review every
small step.

In this case `git add -p` comes to our rescue!

alias: `a = add -p`
result:
![Staging your git changes in patches]({{ site.url }}/assets/awesome-git-aliases/git-a.png)

## More informational git logs

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

alias: `rank = shortlog -sn --no-merges`
result:
![Who works on a project ordered by number of merges]({{ site.url }}/assets/awesome-git-aliases/git-tlog.png)

## Remove all branches merged into your current branch

alias: `bdm = "!git branch --merged | grep -v '*' | xargs -n 1 git branch -d"`


{% highlight bash %}
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
