---
title: CoffeeScript's Magic of Blanks
tags: [Original, Programming, CoffeeScript]
---

### The Problem
CoffeeScript greatly simplified Javascript's syntax, omitting braces, parentheses, semi-colons, and a great deal of commas. This often generates terser code. But, there are totally opposite perspectives regarding readability: [some people](http://buhrmi.tumblr.com/post/5371876452/how-coffeescript-makes-jquery-more-fun-than-ever) belive CoffeeScript cdoe is more readable, while [others](http://ceronman.com/2012/09/17/coffeescript-less-typing-bad-readability/) argue against it. In my opinion, actually, both sides of the coin are true. Consider an example in favor of the positive argument:

{% highlight coffeescript %}
foo
    a: 1
    b: 2
{% endhighlight %}

while compiles into the following Javascript:

{% highlight javascript %}
foo({
    a: 1,
    b: 2
});
{% endhighlight %}

Clearly the Coffee code seems more readable.

Yet another example supporting the negative side:

{% highlight coffeescript %}
foo () -> "foo"
foo() -> "foo"
{% endhighlight %}

these two nearly identical lines generates completely different Javascript:
{% highlight javascript %}
foo(function() {
    return "foo";
});

foo()(function() {
    return "foo";
});
{% endhighlight %}

The first line means passing an anonymous function `() -> "foo"` to the named function `foo`, while the second line is passing the same anonymous function `-> "foo"` (recall that the empty parentheses can be omitted) to the object returned by the same named function `foo`, which could well be a funtion too. 

This huge difference between the subtle change in code sure is a firm argument against the readability of CoffeeScript. Because the only difference in the two lines is the single blank, this example clearly emphasises the importance of blanks in CoffeeScript.

### Finding the Answer
To understand the role of blanks in CoffeeScript, let's start with something that is supposed to be rather simple:

{% highlight coffeescript %}
a b c
{% endhighlight%}

But the question of ambiguity rises immediately: what does this exactly mean? Experiences with other programming languages gives us the following possible answers:

{% highlight coffeescript %}
a(b(c))  # function: a, argument: b(c)
a(b, c)  # function: a, argument: b and c
a(b)(c)  # function: a(b), argument: c
{% endhighlight %}

This involves also the role of commas in CoffeeScript: _they are only used to seperate function arguments and fields of objects_. By knowing this, and the fact that _blanks are never translated to commas_, the second candidate drops out. Now if we use our heads harder, the difference between candidates number 1 and 3 is really a question of _associativity_: are blanks in CoffeeScript left or right associative? If they are right associative, candidate #1 wins; if they are left associative, candidate #3 wins.

Now what does the judge -- the compiler -- say? He chooses candidate #1. That is to say, _blanks in CoffeeScript are right-associative_.

Why is that? Maybe it helps to understand the behaviour of the CoffeeScript compiler in this way:

> It always translates blanks (of course after removing successive and unnecessary blanks) into left parathensis `(`, and adds needed right paranthesis `)` at the end.

### Managing the Answer
Frankly speaking, this is a brilliant choice, since it's the most natural way people write code. Consider now a reall-world example. Say we want to test an array of tags agains an array of regular expressions. For each regular expression, if any of the tags match it, consider it successful, and we want to know if every regular expressions are successful. Thanks to Javascripts's `some` and `every` functionality, we can manage the task by writing the following single line of CoffeeScript code:

{% highlight coffeescript %}
flag = regs.every (r) -> tags.some (t) -> r.test t
{% endhighlight %}

According to the rule we just discovered, replace the blanks after `every`, `some` and `test` by left paratheses, and add three right parantheses at the end. Notice that the blanks before and after `->` should be removed since they are part of the function definiations and are unnecessary. This line is equivalent to 

{% highlight coffeescript %}
flag = regs.every((r) -> tags.some((t) -> r.test(t)))
{% endhighlight %}

meaning passing `t` to `r.test`, using its return value as the return value of a new function `(t) -> ...`, and pass that function as the argument for `tags.some`, whose return value should be returned by another new function `(r) -> ...`, then pass that function as the argument for `regs.every`, and finaly use the return value of `regs.every`.

You may have observed, we actually have read the line from right to left, and it sounds quite natural. That's right. _[It's recommended to read CoffeeScript code from right to left](http://coffeescript.carbonfive.com/)_. It's not that straitforward to always replace blanks with left paratheses in head, but the latter piece of advice comes in handy.

### Summary
I think it's pretty clear now, that after we understand the role of blanks (and commas too), there're no magic at all. Our world of CoffeeScript just got better.

If you have commens about this, either positive or negative, just leave them below. I'd be happy to see them.
