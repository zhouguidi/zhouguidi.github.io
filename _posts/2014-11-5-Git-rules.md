---
layout: post
title: Git rules!
---

> _Git is awesome, GitHub is awesome, and Jekyll is awesome!_

I'm glad I started the journey of [Git], [GitHub] and [Jekyll]. [Git] is a terrific tool for version-control, and [GitHub] is a perfect online repository manager, which also provides top-notch free hosting, powered by [Jekyll], an awesome static site builder with the full power of the [Liquid] theming engine.

Writing my first blog on [GitHub], I think the first thing to write is how to get [GitHub] pages and blogs up and running. This is mainly based on [Barry Clark]'s [tutorial](http://www.smashingmagazine.com/2014/08/01/build-blog-jekyll-github-pages/).

#How does it work
Thanks to [GitHub], publishing a blog-aware website is insanely easy. [GitHub] provides every user three kinds of free web-hosting: personal site, organization site and project site, the simplest being personal site. Creating a personal website is as easy as creating a repository under [GitHub], only that the name of the repository should be _username.github.io_ and the published website will have the url _http://username.github.io_ In the repository, you can put any kind of normal static web files like .html, .css, .js or anything else. More specifically, you can use [Jekyll]-style website structure, and [GitHub] will automatically build it behind your back.

#Step 1: Create it
To do this, the first thing is of course creating a [GitHub] repository (well, the really first thing is to register a [GitHub] account, but I'm assuming you've got that done). [Jekyll] websites could be very complex and cumbersome for a rookie, so [Barry Clark] has built a [template repository][Jekyll-Now] which makes it a breeze to build such a website, without the need to install and configure [Jekyll] and all it's dependencies.

Now head for the [template][Jekyll-Now], and click "Fork" at the top right corner of the page. This will make your own copy of the template. Click "settings" in the right panel, change the repository name into _username.github.io_ where _username_ should be changed into your own [GitHub] user name, apparently. This way you have already created your perfectly running website with blogging facilities. Try it under _http://username.github.io_. Be aware, though, that the page might need up to 10 minutes to be built.

#Step 2: Make it yours
Now that you have your website up and running, you probably want to change all the information to yours. It's a good idea to make a local copy of the repository first:

```bash
git clone git@github.com:username/username.github.io.git
```

Open the file _config.yml in the root directory of your repository, which contains some global settings of your website. In the begining of the file you'll find some informations like your name, the description of the website, and your avatar. You're free to change them. And what's really cool about [Jekyll] is, you can setup links to your social network accounts under the `footer-links` section and things like google analytics.

#Step 3: Post your first blog
So far all you see in your website is a sample blog. Time to post your own. Blogs could be written in any of your favorate mark-up language, but I like markdown. Consulte to [this page](https://guides.github.com/features/mastering-markdown/) for a tutorial of the markdown syntax that [GitHub] supports.

Browse into the `_post` directory in your repository, and you'll see a file called `2014-3-3-Hello-World.md` which is the sample blog. The naming of the blog files is very important in [Jekyll]: the date as YYYY-M-D, the title of the blog, and the language extension. Rename the sample file to fit your needs:

```bash
cd _posts
mv 2014-3-3-Hello-World.md 2014-11-5-My-first-blog.md
```

Open the file with whatever text editor of your choice, and you'll see these lines:

<pre>
---
layout: post
title: Git rules!
---
</pre>

This is where you configure your blog post, and is called "front-matter" in [Jekyll]. The _layout_ entry tells [Jekyll] to use *_layouts/post.html* as the template of this blog, while the _title_ entry, as you may have already guessed, sets the title. The rest of the file is all yours. Write anything in markdown syntax.

After all your changes, don't forget to commit and push to get your website updated:

```bash
git add .
git commit -m "changed something"
git push
```

#Step 4: Customize it


[Git]: http://git-scm.com
[GitHub]: https://github.com
[Jekyll]: http://jekyllrb.com
[Liquid]: http://liquidmarkup.org
[Barry Clark]: http://www.barryclark.co
[Jekyll-Now]: https://github.com/barryclark/jekyll-now
