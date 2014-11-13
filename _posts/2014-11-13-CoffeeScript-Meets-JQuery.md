---
title: When CoffeeScript Meets JQuery
tags: [Note, Programming, CoffeeScript, JQuery]
---

This is a note from Stefan Buhrmester's blog ["How CoffeeScript makes jQuery more fun than ever"](http://buhrmi.tumblr.com/post/5371876452/how-coffeescript-makes-jquery-more-fun-than-ever) which offers an interesting guide through the beauty of both CoffeeScript and JQuery. While the outline of the content and most of the examples are taken from there, I added some points which I think worth mentioning and added something not obvious in the origional article.

> When I first started to work with jQuery a couple of years ago it felt as if I reached programmer heaven. ... Enter CoffeeScript. It’s the same story all over again and is just as addictive. 
> -- Stefan Buhrmester

### Iterate like a boss
With CoffeeScript, where we previously have to write 

{% highlight javascript %}
{% raw %}
$(".li").each(function() {
    $(".div").append($(this).val());
});
{% endraw %}
{% endhighlight %}

we now can write as easy as

{% highlight coffeescript %}
{% raw %}
for li in $(".li")
    $(".div").append($(li).val())
{% endraw %}
{% endhighlight %}

The above Coffee code compiles into the following Javascript:

{% highlight javascript %}
{% raw %}
var li, _i, _len, _ref;

_ref = $(".li");
for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    li = _ref[_i];
    $(".div").append($(li).val());
}
{% endraw %}
{% endhighlight %}

which, when compared to the lucid Coffee code, looks more like junk. Note that in the above Coffee code, we still have to surround the `h3` object by `$()`, as we did before. As is obvious in the compiled code, inside the loop it actually makes a `[_i]` call to the jQuery selecter result, which will return a DOM element, so we have to pass it to `$()` again to make it a jQuery object.

### Bind methods on the fly
Binding a method to an object becomes as easy as this:

{% highlight coffeescript %}
{% raw %}
object =
    func: -> $('#div').click => @element.css color: 'red'
{% endraw %}
{% endhighlight %}

which means binding `$('#div')`'s `click` event to a function which returns what the selected items's `.element.css` method returns.

### Call functions like it’s 2011
This is just about readability. By omitting braces and commas, and by the ability of spreading the code over muliple lines, we can now write much clearer function calls like

{% highlight coffeescript %}
{% raw %}
$.post(
    "/posts/update_title"
    new_title: input.val()
    id: something
    -> alert('done')
    'json'
)
{% endraw %}
{% endhighlight %}

### Sexy initializer
It's too common to every Javascript programmer to write something like this

{% highlight javascript %}
{% raw %}
$(document).ready(function() {
    some();
    init();
    calls();
});
{% endraw %}
{% endhighlight %}

With CoffeeScript this becomes

{% highlight coffeescript %}
{% raw %}
$ ->
    some()
    init()
    calls()
{% endraw %}
{% endhighlight %}

Isn't that beautiful?

Notice the space in the first line, though. This line means call funtion `$` with an anonymous function as its input, but if you miss the space, it means nothing than an error.

### More
I'm sure there are more cheering combinations of the two tools. After finish reading [CoffeeScript: Accelerated JavaScript Development](https://pragprog.com/book/tbcoffee/coffeescript), I think I'm definately gonna write something.
