---
layout: post
title: Install Redmine with automated git integration (Centos, Redhat)
permalink: /blog/install-redmine-with-automated-git-on-centos-redhat/
date: 2010-10-05 13:37:27
categories: Development Tools
comments: true
---

I had a few days work on this one while it was supposed to be done in a hour. The problem? Lack of good documentation. There seems to be no complete tutorial on the Internet how to completely integrate git with Redmine so I figured to make one myself for you my dear reader but also a little bit for myself so I can easily find it back.

<!--more-->

Good to know: I might have used yum but we all know that the repo's of centos en redhad are way behind in version. Please make sure you have extra repo's. I used:
<a title="epel repo" href="http://fedoraproject.org/wiki/EPEL/FAQ#How_can_I_install_the_packages_from_the_EPEL_software_repository.3F" target="_blank">epel</a>
<a title="webtatic repo" href="http://www.webtatic.com/blog/2009/06/php-530-on-centos-5/" target="_blank">webtatic</a>

Make sure you also use repo's for a more updated ruby and gems. I'm going to start with the ruby install right from the bat. Please make sure your server has Apache and Mysql installed. This tutorial won't explain that part.

# Installing Ruby
Redmine works on ruby so we will start with installing ruby. You can install ruby in 2 ways.

1. From the source
2. Trough yum

Thoose the one you prefer I will use the yum method:

    yum install ruby ruby-devel ruby-libs ruby-irb ruby-rdoc ruby-mysql

Just make sure that you have the right version of ruby. The standard repositories don't have the later versions yet so make sure to use other repositories. I used version 1.8.5. Just make sure that you use a compatible version. You can see that here: <a title="Redmine Ruby versions" href="http://www.redmine.org/wiki/1/RedmineInstall" target="_blank">Redmine Ruby Versions</a>

# Installing ruby-gems
Installing ruby-gems goes most of the time by hand:

    wget http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz
    tar xvf rubygems-1.3.1.tgz
    cd rubygems-1.3.1
    ruby setup.rb

# Installing Rails

You need to install rails trough gem. But you need to make sure you install the version that Redmine likes:

    gem install rails -v=2.3.5

# Installing Rack

    gem install rack -v=1.0.1

# Installing mongrel (optional)
You won't need to install mongrel but it makes your site run so much faster so it is recommended you install it.

    gem install mongrel

# Installing Redmine

## Download redmine

First lets download redmine. You can download the latest version at the <a title="Redmine Site" href="http://www.redmine.org/wiki/redmine/Download" target="_blank">Redmine site</a>. Unpack it and put it in the folder you want. I will be using "/home/redmine/redmine" as my redmine root.

## Creating the database

First we need to install the database. In this tutorial we will be using mysql as database driver since it's commonly known. Log into your mysql console and run this:

{% highlight sql %}
create database redmine character set utf8;
create user 'redmine'@'localhost' identified by 'my_password';
grant all privileges on redmine.* to 'redmine'@'localhost';
{% endhighlight %}

## Configuring Redmine
Let's configure Redmine now. Fist we need to copy the Redmine configure file at the right place.

     cd /home/redmine/redmine
     cp config/database.yml.example config/database.yml

Now edit the config to the settings you set the database with.

    production:
        adapter: mysql
        database: redmine
        host: localhost
        username: redmine
        password: my_password

## Generate a session store secret

    cd /home/redmine/redmine
    rake config/initializers/session_store.rb

Or:

    rake generate_session_store

## Create the database structure

    RAILS_ENV=production rake db:migrate
    RAILS_ENV=production rake redmine:load_default_data

## Set the right permissions for the files

    chown -R redmine:redmine files log tmp public/plugin_assets
    chmod -R 755 files log tmp public/plugin_assets

## Test Run redmine

    ruby script/server webrick -p 3000 -e production


People note this is only for testrunning redmine. Don't use it for production. Use one of the many other guides in the Redmine wiki to setup redmine to use either passenger (aka mod_rails) or mongrel to serve up your redmine.

# Installing and automating Git
Now we will start automating all git processes with Redmine. This means when you make a new project it will automatically create a repository for it. Since there are already many tutorials how to do this with svn ours will be about git.

First create a directory where all git repositories will be in. Mine is located at: "/home/redmine/git_repositories"

## Edit your apache
Now edit your httpd.conf to fit your settings:

{% highlight apache %}
    PerlLoadModule Apache::Redmine
    SetEnv GIT_PROJECT_ROOT /home/redmine/git_repositories/
    SetEnv GIT_HTTP_EXPORT_ALL
    ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
    <Location /git>
        RedmineGitSmartHttp yes
        DAV on
        AuthType Basic
        Require valid-user
        AuthName "Git"
        PerlAccessHandler Apache::Authn::Redmine::access_handler
        PerlAuthenHandler Apache::Authn::Redmine::authen_handler
        RedmineDSN "DBI:mysql:database=redmine;host=localhost"
        RedmineDbUser "redmine"
        RedmineDbPass "my_password"
    </Location>
    Alias /git-private /home/redmine/git_repositories
    <Location /git-private>
        Order deny,allow
        Deny from all
        <Limit GET PROPFIND OPTIONS REPORT>
            Options Indexes FollowSymLinks MultiViews
            Allow from 127.0.0.1
            Allow from localhost
        </Limit>
    </Location>
{% endhighlight %}

Maybe you already noticed. That this is completely different from the configuration the Redmine sites gives. This is because we will be using git's git-smart-http protocol. With this you can push your repository straight to the http link. If you are a valid user. For this to work you need to make sure you git version is higher than 1.6.6. Also check all paths for this httpd config since some could be off. Just try to locate the correct files with "find / -name yourfilenamehere".

You will need to patch your Redmine.pm to support. this protocol. You can find the patch for Redmine.pm here: <a title="Redmine.pm Patch" href="http://www.redmine.org/issues/4905" target="_blank">Redmine.pm Patch</a> Note:please make sure this patch isn't already committed else you might patch a already fixed file. Also use linux "patch" to patch the file.

If everything is working correctly you should be able to push to the httpd "IF" your repository exists and is setup the right way.

## Setting up Auto creation and checking
Some people might want Redmine to auto create their repository when a new project is added and keep tracking the changes. For this you will need to add 2 lines to the cron:

    */1 * * * * root ruby /home/redmine/redmine/script/runner "Repository.fetch_changesets" -e production
    */1 * * * * root ruby /home/redmine/redmine/extra/svn/reposman.rb -s /home/redmine/git_repositories/ -r [external-redmine-link]:3000 -u /home/redmine/git_repositories --scm git -k [repository-key] -g redmine -o redmine --verbose >> /var/log/reposman.log

This should be all to get your redmine / git integration working if I missed something or if you get errors. Please comment. I will try to edit the tutorial and help you out where I can.
