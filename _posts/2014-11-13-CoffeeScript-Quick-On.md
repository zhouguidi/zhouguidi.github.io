---
title: CoffeScript Quick On
tags: [Note, Programming, CoffeeScript]
---

This is a note from the lucid tutorial [Essence of CoffeeScript](http://coffeescript.carbonfive.com/) to get a quick glance of CoffeeScript. The headings and examples are taken from there, but I added some thing I think worth mentioning.

### Key Fundamentals

#### Punctuation is usually optional, so skip it ;}),
1. Function calls don't need parentheses.
2. String concatination is the same as Javascript.
3. Javascript objects like console are still usable.

{% highlight coffeescript %}
{% raw %}
nickname = prompt "what's your nickname?"
console.log 'Hi ' + nickname
{% endraw %}
{% endhighlight %}

#### Use indentation instead of curly braces
1. `if` statement doesn't need parenthese.
2. Indentation instead of `{}`.
3. String interpolation in the notation of `"#{now}"`.

{% highlight coffeescript %}
{% raw %}
date = new Date()
hour = date.getHour()
if hour > 17
    now = 'night'
else
    now = 'day'
console.log 'It is now #{now} time.'
{% endraw %}
{% endhighlight %}

#### Every expression returns a value
1. A single variable or literal constant like the `'night'` and `'day'` in the `if` statement above returns itself.
2. `if` statement returns the value returned by the last child statment in the selected branch. True for other statements too.

{% highlight coffeescript %}
{% raw %}
date = new Date()
hour = date.getHours()
now = if hour > 17 then 'night' else 'day'
console.log "It is now #{now} time."
{% endraw %}
{% endhighlight %}

#### Never specify `var`
1. Every variable is made local by implicitly adding a `var` in the front. This saves programmers a lot from the danger mixing up local and global variables.
2. Using `var` explicitly is actually forbidden -- you'll get a compile error.

### Some Useful Tips

#### Read a line from right to left
{% highlight coffeescript %}
{% raw %}
console.log 'Hi ' + prompt "What's your nickname?"
{% endraw %}
{% endhighlight %}

#### Use punctuation wherever it adds readability
{% highlight coffeescript %}
{% raw %}
console.log 'Hi ' + (prompt "What's your nickname?")
console.log 'Hi ' + prompt("What's your nickname?")
{% endraw %}
{% endhighlight %}

#### Object literals are all over the place
1. Become familiar with an object literal (or hash) without its punctuation.
2. The : indicates a key: value pair.
3. Key value pairs need to be separated with a comma when on the same line.
4. Key value pairs don't need comma separation when on their own line.
5. Key value pairs that belong to the same hash are indented at the same level.

{% highlight coffeescript %}
{% raw %}
options = readonly: true, theme: 'solarized'

theme =
    color:
        text: 'blue'
        background: 'white'
    font:
        family: 'SourceCode Pro'
        size: '16px'

console.log 'options are ', options
{% endraw %}
{% endhighlight %}

### A Function Is This Way ->

#### Use dash rocket `->` to define a function
1. Anonymous functions (closures?) are used quite commonly.
2. Use the `(arg) -> body` notation.

{% highlight coffeescript %}
{% raw %}
reportStatus = (msg) -> console.log 'Status: ', msg
reportStatus 'ok'
{% endraw %}
{% endhighlight %}

#### A function with no arguments doesn't need `()`
1. Get used to this (a bit weird?) notation.
2. Notice that `()` is needed to call the function, but not to define it.

{% highlight coffeescript %}
{% raw %}
getHostname = -> console.log location.hostname
getHostname()
{% endraw %}
{% endhighlight %}

#### A function automatically returns its final value
{% highlight coffeescript %}
{% raw %}
getHostname = -> location.hostname
console.log getHostname()
{% endraw %}
{% endhighlight %}

#### Indent the function body
{% highlight coffeescript %}
{% raw %}
reportRootURL = ->
    protocol = location.protocol
    hostname = location.hostname
    console.log "#{protocol}//#{hostname}"

reportRootURL()
{% endraw %}
{% endhighlight %}

#### Get used to passing a function
{% highlight coffeescript %}
{% raw %}
quoteCallback = (quote)-> console.log quote
apiEndpoint = 'https://api.github.com/zen'
jQuery.get apiEndpoint, quoteCallback
{% endraw %}
{% endhighlight %}

### Some Conditional Love

#### The body of an if can come first
{% highlight coffeescript %}
{% raw %}
timeOfDay = 'morning' if hour < 11
{% endraw %}
{% endhighlight %}
This could come in handy.

#### Use unless to flip an if else
`unless` runs the statement only if the condition is untrue.

{% highlight coffeescript %}
{% raw %}
askForGeoLocation = ->
    return alert 'Seriously? You gotta update your browser!' unless navigator.geolocation
    alert 'Your browser is about to ask you to allow geolocation'
    navigator.geolocation.getCurrentPosition positionCallback

positionCallback = (position)->
    point = position.coords
    console.log "Lat: #{point.latitude}, Lng: #{point.longitude}"

askForGeoLocation()
{% endraw %}
{% endhighlight %}

### The Existential `?` Operator

#### Use `?` to check if something exists
1. `?` checks for the existence of the preceeding variable and produces `true` if it does and `false` otherwise.
2. Note that using a non-existing variable (equals `undefined`) is a syntax error and cannot even be used for the condition in `if` statements, while a variable equals `nil` does exist.:w
3. `?` can be used to avoid errors all together.

{% highlight coffeescript %}
{% raw %}
console.log 'unicorns are not real!' unless unicornsExist
console.log 'unicorns are not real!' unless unicornsExist?

unicornsExist = false
console.log 'unicorns are real!' if unicornsExist
console.log 'unicorns are real!' if unicornsExist?
{% endraw %}
{% endhighlight %}

#### Use `?` to set default values
`a ?= b` means "if `a` doesn't exist, create it and initialize it using `b`; but if it does, do nothing". This is a great method to set default value.

{% highlight coffeescript %}
{% raw %}
setProfile = (profile)->
    profile ?= {}
    profile.name ?= 'guest'
    console.log 'profile:', profile

setProfile()
setProfile age: 25
setProfile name: 'misty'
{% endraw %}
{% endhighlight %}

#### Use `?` to call a function only if it exists
`foo?()` means "call function `foo` if it exists, otherwise do nothing".

{% highlight coffeescript %}
{% raw %}
barn = 
    horse:
        run: ()-> 'gallop' for i in [0..3]

console.log barn.horse.run()
console.log barn.horse.fly()
console.log barn.horse.fly?()
{% endraw %}
{% endhighlight %}

#### Use `?` to soak up errors in chain
The last line above means "if `p` exists, and it has a method `run`, then call it". Notice the second last line produces error.

{% highlight coffeescript %}
{% raw %}
barn = 
    horse:
        run: ()-> 'gallop' for i in [0..3]

h = barn.horse
p = barn.pig

console.log h.run?()
console.log h.fly?()

console.log p.run?()
console.log p?.run?()
{% endraw %}
{% endhighlight %}

### Some Loopy Situations

#### Use `in` to loop through an array
1. Create a range using something like `[0..9]`.
2. `for item in array` like in some other languages.

{% highlight coffeescript %}
{% raw %}
printDigits = ()->
    digits = [0..9]
    for digit in digits
        console.log 'digit: ', digit
{% endraw %}
{% endhighlight %}

#### Use `of` to loop through a hash
{% highlight coffeescript %}
{% raw %}
reportTheme = ()->
    theme = text: 'blue', button: 'red'
    for key, value of theme
        console.log "#{key} is set to #{value}"
{% endraw %}
{% endhighlight %}

#### The body of a loop can come first
{% highlight coffeescript %}
{% raw %}
digits = [0..9]
console.log i for i in digits

theme = {text: 'blue', button: 'red'}
console.log key,'=', val for key,val of theme
{% endraw %}
{% endhighlight %}

#### A loop retuns an array
{% highlight coffeescript %}
{% raw %}
oddDigits = (1 + i*2 for i in [0..4])
{% endraw %}
{% endhighlight %}
This is called "array comprehension" like in Python.

### Working With Class

#### Defining a class is simple
1. Use `class` to define a class.
2. Use `new` to create an instance.

{% highlight coffeescript %}
{% raw %}
class Mutant
    fight: (badGuy)-> 'Spin a Web onto ' + badGuy

spidy = new Mutant
spidy.fight('Lizard')
{% endraw %}
{% endhighlight %}

#### `this` has an alias: `@`
1. Writing `@method` is actuall writing `this.method`.
2. `this` or `@` refers to the class that we're defining.

{% highlight coffeescript %}
{% raw %}
class Mutant
    superPower: 'do nothing'
    fight: (badGuy)-> @superPower + ' onto ' + badGuy

spidy = new Mutant
spidy.fight('Boomerang')
spidy.superPower = 'Spin web'
spidy.fight('Boomerang')
{% endraw %}
{% endhighlight %}

#### Use a constructor for initialization
1. Constructor is defined by the `constructor` element function.
2. Initialize the instance by passing arguments to the `new` statement.

{% highlight coffeescript %}
{% raw %}
class Mutant
    superPower: 'do nothing'
    constructor: (power) -> @superPower = power
    fight: (badGuy)-> @superPower + ' onto ' + badGuy

spidy = new Mutant 'spin web'
spidy.fight 'SandMan'
{% endraw %}
{% endhighlight %}

#### Inheriting from a Class is Simple
1. Define subclass by saying that the child `extend`s the father.
2. Call superclass's constructor by `super`.

{% highlight coffeescript %}
{% raw %}
class Mutant
    superPower: 'do nothing'
    constructor: (power) -> @superPower = power
    fight: (badGuy)-> @superPower + ' onto ' + badGuy

class NinjaTurtle extends Mutant
    constructor: () ->
        super('Kung Fu')

raphael = new NinjaTurtle
raphael.fight('Shredder')
{% endraw %}
{% endhighlight %}
