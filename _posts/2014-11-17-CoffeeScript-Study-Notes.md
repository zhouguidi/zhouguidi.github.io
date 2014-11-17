---
title: CoffeeScript Study Notes
tags: [Note, Programming, CoffeeScript]
---
This is my study note after reading [CoffeeScript: Accelerated JavaScript Development](https://pragprog.com/book/tbcoffee/coffeescript). Only the most important points that I'm not familiar with are recorded, with some minor changes in the order.

### Functions, scope, and context
* function definination: `-> 'hello'`
* terminal output: `console.log 'hello'`
* run a function: `do -> 'hello'`, or `(-> 'hello')()`
* auto return last statement's value, or use `return`
* functions without return value perform better
* named function is a variable assigned a function value: `hi = -> 'hello'`
* thus functions must be defined before they are used
* string interpolation: `"hello, #{expression}!"`
* single quoted string: no string interpolation
* operator `+` doesn't ignore spaces: `foo +5` is compiled to `foo(+5)`
* function with arguments: `(a, b) -> a + b`
* `is` is compiled to `===`
* test type: `if typeof num is 'number'`
* test integer: `if num is Math.round num`
* throw exception: `throw 'something wrong'`
* capture exception: `try ... \n catch e \n console.log e`
* the only way to create a scope is by defining a function
* If a variable is defined before a function defination, inside the function a variable with the same name is always considered refering to the one in the *outer* scope. Otherwise if a function creates or uses a variable that is not defined before the function itself, it's a local variable only available inside the function scope.
* Such relative position between variable and function definations is the only way to determine whether a variable is local to the function scope. Note that assigning to a variable inside a function does *not* create a local variable, it's merely re-assigning to it.
* An alternative comprehension is that function scope is a sub-scope of its outer scope, which inherites all the variables. But new variables inside the function scope could not live outside.
* Inside a named function, the function itself is always available since it's created before it's defined
* The only way to define a variable is by assigning to it.
* `@` is an alias to `this` or `this.`, meaning the context (caller) of a function. When a method of an object is called, its context is the object.
* It's possible to call a function with a different context by using the function's `apply` or `call` method (function is also object): `cat.setName.apply hourse, ['porny']`
* The `new` keyword takes a function, not just objects, meaning "don't return the function's value, instead create an object and call the function, using this object as the function's context, and then return the object".
* A little summary (earlier has higher privilege):
    1. If there is the `new` keyword before a function call, then the newly created object is the context
    2. When calling a function with `call` or `apply`, then the first argument is the context
    3. When calling an object's method, the object is the context
    4. Otherwise the function's context is the global context.
* There is also a way to always use a particular object as the context, regardless where and how the function is called: the fact arrow `=>`. A function using the fact arrow will always have the same context as where it is defined.
* There's a convenient alias to change object's attribute: `setName = (@name) ->` is equivalent to `setName = (name) -> @name = name`
* `?` returns `true` when the variable exists in current scope (and by inheritage its father scope), *and* it's not `null` or `undefined`
* `unless` is an alias to `if not`
* `a?b` is an alias to `if a? then a else b`
* `c ?= d` is an alias to `c = d unless c?`
* default value of function argument: `(name = 'jack') -> ...`
* CoffeeScript's default value is based on `?` test, thus explicitly passing `null` or `undefined` to an argument will also make it using the default value.
* In CoffeeScript (as in Javascript), logical operatans can be anything besides `true` and `false`. `null`, `undefined`, `0` and `""` are considered `false` and any other values are considered `true`
* In CoffeeScript (as in Javascript), logical operations return their operatans instead of `true` and `false` like in other languages: `c = a or b` is equivalent to `c = if a then a else b`, `c = a and b` equals `c = if a and b then b else if not a and not b then a else if not a and b then a else if a and not b then b`
* In function definations, when using an expression as default value, the expression will be evaluated inside the function before anything else. Thus `foo = (arg = @name) -> ...` is the same as `foo = (arg) -> \n arg = @name \n ...`
* Variant length arguments: `foo = (arg1, otherArgs...) -> ...`. Inside the function, `otherArgs` will be an array.
* Variant length argument need not to be the last argument: it can be the first or anywhere. Non-variant arguments have privilege.
* When calling a function, `...` could be attached to an array to spread it as function's arguments: `foo(1, arr...)` is the same as `foo(1, arr[0], arr[1], ...)`.
### Collections and iteration
* Create an object: `obj = new Object()`, or `obj = {}`
* If the name of an attribute doesn't contain any special character, then use `obj.attr` to refer to it. Otherwise use `obj['attr']`.
* `x = 'name' \n obj[x]` is equal to `obj.name`. Any expression beteen the brackets will be evaluated and converted to string.
* JSON object: ` foo = {name: 'john', age: 50}`. If attribute name contains special characters, it must be surrounded by quotation marks.
* In CoffeeScript, the curly brackets are optional, and if written on seperate lines, the commas could be omitted too.
* In CoffeeScript, `x = 1 \n obj = {x}` is the same as `x = 1 \n obj = {x: x}` but only when curly brackets are used too.
* `a?.b?c` is an alias to `if a? and a.b? then a.b else c`
* `foo?()` is an alias to `if foo? then foo()`
* Array: `names = ['james', 'jack', 'john']`, same as `names = new Array() \n names[0] = 'james' \n names[1] = 'jack' \n names[2] = 'john'`
* Array are still objects (hash tables), whose indexes are strings, rather than integers like in other languages
* Quick range: `a = [1..3]`. If begin index greater than end index, then return reversed array
* Array slicing: `arr[1..3]` or `arr[1..]`, or `arr[1..-1]`. If begin index greater than end index, then return an empty array
* Assigning to array slice: `arr[1..3] = arr2`. If range is empty, then insert before the begin index
* Iterate attributes of object: `for key, value of object`, `value` is optional
* Iterate instance attributes, rather than static attributes, use `for own ...`
* Iterate array: `for val in array by step`, `step` is optional, defaulting to 1
* When iterating a range `[max..min]`, `step` could be negative. **When iterating an array, `step` should not be negative**, otherwise the iteration will not stop
* Optional conditioning: `for ... when ...`, works for both `of` and `in`
* `of` and `in` used as operators to test existence: `names = ['james', 'jack', 'john'] \n 'jack' in names`, or `germanToEnglish = {'ja': 'yes', 'nein': 'no'} \n 'ja' of germanToEnglish`
* Conditional iteration: `dosomething() while test()` or `dosomething() until test()`
* Infinite looping: `loop \n ... break ...`
* List comprehension: `arr = (-num for num in [1..5] by 2)` -- single line form need to put iteration body in front and use paratheses. `arr = for num in [1..5] by 2 \n num + 2`
* Array model match: `[first, middle, last] = ['Joey', 'T', 'Plumber']` which is equal to `first = 'Joey'; middle = 'T'; last = 'Plumber'`
* Variant lengh argument can also be used in array model match: `[best, rest...] = students`
* Object model match: `{X: myX, y: myY} = Rect` == `myX = Rect.X; myY = Rect.Y`
* Very convenient: `{X, Y} = Rect` == `X = Rect.X; Y = Rect.Y`
* Array and object model match mixed: `{languages: [favorite, others...]} = resume` == `[favorite, others...] = resume.languages`
### Modules and classes
* CoffeeScript wraps every file to a single namespace, so a file is a module.
* To share data across modules, attach data to the global object `window` in browser environment or `global` in Node.js
* Better practice is to attach data to an attribute with the same name as the current file. Then in other modules simply use `modulename.data` to refer to it
* class defination: `class Tribble \n property: 0 \n method: -> ...`
* Constructor is defined by `constructor: -> ...`
* Class (static) property and method are written with a `@` prefix, with the exception of the constructor
* Instance property and method are written as is
* Inside instance methods and the constructor, `@` means the instance, while inside static methods except the constructor, `@` means the class
* Class inheritage is defined by `class A extends B`
* Inside child class methods, `super()` means call the same method of the father (with no arguments)
* `super` without paratheses is a special shortcut for passing all the current method's arguments to its father
* To test whether an object is an instance of a class, use `a instanceof A`
* Switch statement: `switch caption \n when 'Kirk', 'Picard', 'Archer' \n ... \n when 'Janeway' new Voyager() \n else throw new Error("wrong!")`
### Web interactivity with JQuery
* JQuery selectors are a superclass of CSS
* Name a JQuery object by a prefix `$` is a common coding convention
* JQeury getter functions only get the first match, with the exception of `text()` which returns the joined string of all matches
* Setter functions apply to all matches
* `$("#header imag")` is the same as `$("#header").find("img")`
* `$("#header > img")` is the same as `$("#header").children("img")`
* `$("li:has(a)")` to select the list items that contain links
* Binding events: `$("h1").click -> $(@).html $(@).html + "!"`
* In binded event handler functions, `@` is the current DOM object that triggers the event
### Server-side apps with Node.js
* Node.js module export and include: in included file attach data to `exports`, in other modules use `util = require './util'`
* In Javascript files, if want to include CoffeeScript module, use `require('coffee-script')` before including the module
* If no path is specified for the included module, Node will search its path definedin `require.paths`
* CoffeeScript `do (x, sum) -> ...` is same as `((x, sum) -> ...)(x, sum)`, used to create closures
