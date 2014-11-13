---
title: When CoffeeScript Meets JQuery
tags: [note, programming, CoffeeScript, JQuery]
---

This is a note from Stefan Buhrmester's blog ["How CoffeeScript makes jQuery more fun than ever"](http://buhrmi.tumblr.com/post/5371876452/how-coffeescript-makes-jquery-more-fun-than-ever) which offers an interesting guide through the beauty of both CoffeeScript and JQuery. While the outline of the content and all the examples are taken from there, I added some points which I think worth mentioning.

> When I first started to work with jQuery a couple of years ago it felt as if I reached programmer heaven. ... Enter CoffeeScript. It’s the same story all over again and is just as addictive. 

### Iterate like a boss
With CoffeeScript, there's no need to write 

{% highlight javascript %}
{% raw %}
$(".class").each(function() {...})
{% endraw %}
{% endhighlight %}

again. Now it's just as easy as

{% highlight coffeescript %}
{% raw %}
formValues = (elem.value for elem in $('.input'))
{% endraw %}
{% endhighlight %}

and you get the extra gains of collecting the results into an array. The above Coffee code compiles into the following Javascript:

{% highlight javascript %}
{% raw %}
var elem, formValues;
formValues = (function() {
    var _i, _len, _ref, _results;
    _ref = $('.input');
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        elem = _ref[_i];
        _results.push(elem.value);
    }
    return _results;
})();
{% endraw %}
{% endhighlight %}

which, when compared to the lucid Coffee code, looks more like junk.

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
$->
    some()
    init()
    calls()
{% endraw %}
{% endhighlight %}

Isn't that beautiful?

### More
I'm sure there are more cheering combinations of the two tools. After finish reading [CoffeeScript: Accelerated JavaScript Development](https://pragprog.com/book/tbcoffee/coffeescript), I think I'm definately gonna write something.
