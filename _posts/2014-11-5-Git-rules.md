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
Now that you have your website up and running, you probably want to change all the information to yours. 

#Step 3: Post your first blog

#Step 4: Customize it


[Git]: http://git-scm.com
[GitHub]: https://github.com
[Jekyll]: http://jekyllrb.com
[Liquid]: http://liquidmarkup.org
[Barry Clark]: http://www.barryclark.co
[Jekyll-Now]: https://github.com/barryclark/jekyll-now
