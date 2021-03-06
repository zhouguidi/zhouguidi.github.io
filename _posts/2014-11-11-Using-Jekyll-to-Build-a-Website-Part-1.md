---
title: Using Jekyll to Build a Website (Part 1)
tags: [Tutorial, Web, GitHub_Pages, Jekyll, Liquid]
belongs: blogs
---

According to its website, Jekyll is a simple, blog-aware, static site generator. Jekyll defines a site structure, uses a processor to convert properly organized template pages into html pages, thanks to the Liquid templating engine. Because of its well balanced power and ease of use, it has been extensively used to build website all around the world. GitHub Pages adopts Jekyll as the site generator, too.

This is a brief tutorial on Jekyll and (a little bit) Liquid. I try to describe here how to use Jekyll to build a static website with blogging facilities. The focus will be on GitHub Pages, but since Jekyll outputs static websites, it's perfectly possible to just upload the generated website to any hosting service, including the local host.

### Getting Started
First things first. We need to register for a GitHub Pages site. After getting a GitHub account, simply create a repository named `username.github.io` where `username` should be substituted with your actual user name. Now if you throw a starter page named `index.html` like this one

{% highlight html %}
{% raw %}
<!DOCTYPE html>
<html>
    <body>
        <h1>Hello, GitHub!</h1>
    </body>
</html>
{% endraw %}
{% endhighlight %}

in a few minutes your website will already be running under `http://username.github.io`. But thanks to Barry Clark's Jekyll-now project, we can easily start off something real easy. Let's do it.

Now go to `https://github.com/barryclark/jekyll-now`, click `Fork` at the top right corner of the page. A new repository will be created for you. Click `settings` in the right panel, and change the repository's name to `username.github.io`. If you have already created that yourself, you'll have to delete it. By doing this, a Jekyll powered website is created. GitHub Pages will run Jekyll automatically and in a few minutes you can see your new website. Take a little while to browse through the contents of the forked repository and learn the basic structure of a Jekyll site. You can already change some information to yours, like your name, the description of the site, etc.

### Installing Jekyll
I like working on my local machine. Let's fire up a terminal and type

{% highlight bash %}
{% raw %}
git clone git@github.com:username/username.github.io
{% endraw %}
{% endhighlight %}

to clone the repository locally. Although installing Jekyll locally is not required to get the GitHub Pages website to work -- GitHub Pages have Jekyll installed and run behind your back -- having Jekyll on your local machine often comes in handy. It has some advantages including:

+ The ability to use plugins and external tools. GitHub Pages only have very limited basic plugins installed and it's not possible to install your own.
+ Building locally avoids uploading temporary files to the server.
+ It enables us to quickly view and debug our pages using a local server.

Jekyll is written in Ruby, so we have to install it. It also depends on Bundler, RedCloth, and NoteJS. In Ubuntu, installing these is very easy:

{% highlight bash %}
{% raw %}
sudo apt-get install ruby ruby1.9.1-dev nodejs
sudo gem install bundler RedCloth
bundle install
sudo gem install jekyll
{% endraw %}
{% endhighlight %}

### Basic Usage
If we organize our site the way suggested by Jekyll, running

{% highlight bash %}
jekyll build
{% endhighlight %}

is sufficient to build the site. Under the hood, Jekyll first detect the site structure, read site-wise configuration, scans for every file starting with a YAML frontmatter, then converts them to plain HTML. It also converts files written in common mark-up languages like Markdown or Textile to HTML. The generated website is by defualt under the `_site` directory in the repository. More details are going to follow in later sections and posts. 

To have an immediate idea of how your website looks like, run the following command

{% highlight bash %}
jekyll serve
{% endhighlight %}

and the website will be available on localhost under port number 4000. So type in the location bar of your browser

{% highlight http %}
localhost:4000
{% endhighlight %}

and you'll see it. When the server is running and you change some of the files, Jekyll will detect it and force a rebuild so you can see the changes by refreshing the browser.

### Website Structure
A typical Jekyll site usually consits of at least the following parts:

<dl>
    <dt>_config.yml (file)</dt>
    <dd>Site-wise configuration file written in YAML format, with predefined or customized variables. These variables will be avialable in all pages as `site.var-name`.</dd>
    <dt>_drafts (directory)</dt>
    <dd>Where draft posts are kept. Drafts can be in Markdown, Textile, and HTML formats, they are posts still writting, so are not published and doesn't have a specific date.</dd>
    <dt>_includes (directory)</dt>
    <dd>Contains partial HTML files (e.g., header, footer etc) which will be included in other pages by using `{{ "{%" }} include xxx.html %}` Liquid tag.</dd>
    <dt>_layouts (directory)</dt>
    <dd>Contains HTML files which serve as layouts for other pages. By writting `layout: page` in the YAML frontmatter (see later) of a page, this page's content is substituted into the `{{ "{{" }} content }}` Liquid tag inside `_layouts/page.html`. In this way, once the common layouts are designed, we can really focus on the contents of our pages. Jekyll will do the rest. Be advised that layout files could themselves use another layout.</dd>
    <dt>_posts (directory)</dt>
    <dd>This is where to put the finished and ready to publish blog posts in either mark-up language. The names of these files musth follow `YYYY-MM-DD-Title.Lang` format, where `YYYY-MM-DD` is the date, `Title` is the title of the post, and `LANG` is the mark up language extension.</dd>
    <dt>_data (directory)</dt>
    <dd>Other than `_config.yml`, additional data could be put under this directory, which are available as `site.data.file-name.var-name`.</dd>
    <dt>_site (directory)</dt>
    <dd>The generated site. No need to concern.</dd>
    <dt>index.html (file)</dt>
    <dd>The home page. It could actually be of either mark up format. Normally it should reference a layout.</dd>
    <dt>about (directory)</dt>
    <dd>Contains a page named `index.html`. This is not necessary, just to show you that instead of being in the root directory, pages can actually be anywhere, and that the `index.html` file could be reached by the url `username.github.io/about` without the need to use the full path name with the file type extension.</dd>
    <dt>404.html (file)</dt>
    <dd>The page to show when a non-existing page is requested.</dd>
</dl>

The starter Jekyll-now site have some of the above, while also with a few missing or different. How does the structure exactly look like is not central, but the configuration and the layout machenism are indeed very core to Jekyll and Liquid. We'll have better understanding on them in the next post.
