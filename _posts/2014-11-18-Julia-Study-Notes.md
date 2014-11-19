---
title: Julia Study Notes
tags: [Note, Programming, Julia]
---

### Getting Started
* Julia REPL: `julia`
* In Julia REPL, expressions are evaluated immediately. Only those without trailing semicolon is shown.
* Whether or not the results are shown, a special variable `ans` is always bounded to the value of the last evaluated expression. It's only available in REPL.
* To evaluate a file: `include("file.jl")`
* Run Julia source files from the shell: `julia script.jl arg1 arg2 ...`.
* Command-line arguments are avaiable inside the script by the global constant `ARGS`.
* Run Julia code inside a string: `julia -e 'for x in ARGS; println(x); end' foo bar`
* Start Julia in parallel mode with the `-p` or `--machinefile` options. `-p n` will launch an additional n worker processes, while `--machinefile file` will launch a worker for each line in file `file`.
* Julia initialization file: `~/.juliarc.jl`

### Variables
* Variables in Julia are names bounded to a value.
* Case-sensitive. 
* Unicode (UTF-8) names are allowed.
* Input LaTeX-style symbol names like `\delta` by tab-completion.
* Built-in variable `pi`.
* The only explicitly disallowed names for variables are the names of built-in statements.
* Style convention: 
    * names of variables are in lower case with underscores; 
    * names of types begin with a capital letter with CamelCase; 
    * names of functions and macros are in lower case, without underscores; 
    * functions that modify their inputs have names that end in `!`.

### Integers and Floating-Point Numbers
* Integer types: `Int8, Uint8, Int16, Uint16, Int32, Uint32, Int64, Uint64, Int128, Uint128, Bool, Char`
* Char natively supports representation of Unicode characters.
* Floating-point types: `Float16, Float32, Float64`
* All numeric types interoperate naturally without explicit casting, thanks to a flexible, user-extensible type promotion system
* The default type for an integer literal depends on whether the target system has a 32-bit architecture or a 64-bit architecture
* `typeof(1)`
* The Julia internal variable `WORD_SIZE` indicates whether the target system is 32-bit or 64-bit.
* Larger integer literals that cannot be represented using only 32 bits but can be represented in 64 bits always create 64-bit integers, regardless of the system type
* Unsigned integers are input and output using the `0x` prefix and hexadecimal.
* The size of the unsigned value is determined by the number of hex digits used.
* Binary and octal literals are also supported, by using the `0b` and `0o` prefixes.
* The minimum and maximum representable values of primitive numeric types such as integers are given by the `typemin` and `typemax` functions
* In Julia, exceeding the maximum representable value of a given type results in a wraparound behavior.
* Integer division (the `div` function) has two exceptional cases: dividing by zero, and dividing the lowest negative number (`typemin`) by -1. Both of these cases throw a `DivideError`. The remainder and modulus functions (`rem` and `mod`) throw a DivideError when their second argument is zero.
* Floating-point literals are all `Float64` values. Literal `Float32` values can be entered by writing an `f` in place of `e`.
* Convert: `float32(-1.5)`
* Half-precision floating-point numbers are also supported (`Float16`), but only as a storage format. In calculations they’ll be converted to `Float32`.
* Floating-point numbers have two zeros, positive zero and negative zero. They are equal to each other but have different binary representations.
* Use `bits` function to see a variable's binary expression.
* Special floating-point values: `Inf16, Inf32, Inf, -Inf16, -Inf32, -Inf, NaN16, NaN32, NaN`.
* Julia provides the `eps` function, which gives the distance between `1.0` and the next larger representable floating-point value: `eps(Float32); eps(Float64); eps();`
* The `eps` function can also take a floating-point value as an argument, and gives the absolute difference between that value and the next representable floating point value. That is, `eps(x)` yields a value of the same type as `x` such that `x + eps(x)` is the next representable floating-point value larger than `x`.
* The distance between two adjacent representable floating-point numbers is not constant, but is smaller for smaller values and larger for larger values.
* Julia also provides the `nextfloat` and `prevfloat` functions which return the next largest or smallest representable floating-point number to the argument respectively.
* If a number doesn’t have an exact floating-point representation, it must be rounded to an appropriate representable value. The default mode is to round to the nearest representable value.
* Julia allows variables to be immediately preceded by a numeric literal, implying multiplication: `2x^2 - 3x + 1; 2^2x`
* The precedence of numeric literal coefficients is the same as that of unary operators such as negation. So `2^3x` is parsed as `2^(3x)`, and `2x^3` is parsed as `2*(x^3)`
* Numeric literals also work as coefficients to parenthesized expressions: `2(x-1)^2 - 3(x-1) + 1`
* Parenthesized expressions can be used as coefficients to variables, implying multiplication of the expression by the variable: `(x-1)x`
* *Neither* juxtaposition of two parenthesized expressions, nor placing a variable before a parenthesized expression, however, can be used to imply multiplication: `(x-1)(x+1); x(x+1)`
* No whitespace may come between a numeric literal coefficient and the identifier or parenthesized expression which it multiplies.
* Expressions starting with 0x are always hexadecimal literals. Expressions starting with a numeric literal followed by e or E are always floating-point literals.
* Literal zero of type `x` or type of variable `x`: `zero(x)`; Literal one of type `x` or type of variable `x`: `one(x)`.

### Mathematical Operations and Elementary Functions
* Inverse divide: `x/y` equivalent to `y/x`.
* Positive zero is equal but not greater than negative zero.
* `NaN` is not equal to, not less than, and not greater than anything, including itself.
* Test: `isfinite(x); isinf(x); isnan(x);`
* Comparisons can be arbitrarily chained: `1 < 2 <= 2 < 3 == 3 > 2 >= 1 == 1 < 3 != 5`
* Chained comparisons use the `&&` operator for scalar comparisons, and the `&` operator for elementwise comparisons, which allows them to work on arrays.
* The operator `.<` is intended for array objects; the operation `A .< B` is valid only if A and B have the same dimensions.
* The operator returns an array with boolean entries and with the same dimensions as A and B. Such operators are called elementwise.
* The middle expression is only evaluated once, rather than twice as it would be if the expression were written as `v(1) < v(2) && v(2) <= v(3)`.
* The order of evaluations in a chained comparison is undefined. It is strongly recommended not to use expressions with side effects (such as printing) in chained comparisons.
* Rounding functions: `round(x), iround(x), floor(x), ifloor(x), ceil(x), iceil(x), trunc(x), itrunc(x)`
* Division functions: `div(x,y), fld(x,y), cld(x,y), rem(x,y), divrem(x,y), mod(x,y), mod2pi(x), gcd(x,y...), lcm(x,y...)`
* Sign and absolute value functions: `abs(x), abs2(x), sign(x), signbit(x), copysign(x,y), flipsign(x,y)`
* Powers, logs and roots: `sqrt(x), cbrt(x) , hypot(x,y), exp(x), expm1(x), ldexp(x,n), log(x), log(b,x), log2(x), log10(x), log1p(x), exponent(x), significand(x)`
* Trigonometric and hyperbolic functions: `atan2(x, y), sinpi(x), cospi(x), sind(x), cosd(x)`
* Special functions: `gamma(x), lgamma(x), beta(x,y), lbeta(x,y)`

### Complex and Rational Numbers
* The global constant `im` is bound to the complex number i, representing the principal square root of -1.
* Standard functions to manipulate complex values are provided: `real, imag, conj, abs, abs2, angle`
* Note that mathematical functions typically return real values when applied to real numbers and complex values when applied to complex numbers. For example, `sqrt` behaves differently when applied to `-1` versus `-1 + 0im` even though `-1 == -1 + 0im`.
* Use the `complex` function instead to construct a complex value directly from its real and imaginary parts `complex(a,b)` to avoid the multiplication and addition operations.
* Rationals are constructed using the `//` operator: `2//3`
* If the numerator and denominator of a rational have common factors, they are reduced to lowest terms such that the denominator is non-negative.
* The standardized numerator and denominator of a rational value can be extracted using the `num` and `den` functions.
* Constructing infinite rational values is acceptable. Trying to construct a NaN rational value, however, is not.

### Strings
* `String` is an abstraction, not a concrete type — many different representations can implement the `String` interface, but they can easily be used together and interact transparently. Any string type can be used in any function expecting a `String`.
* Julia has a first-class type representing a single character, called `Char`.
* Strings are immutable.
* Conceptually, a string is a partial function from indices to characters — for some index values, no character value is returned, and instead an exception is thrown.
* Julia supports the full range of Unicode characters: literal strings are always ASCII or UTF-8 but other encodings for strings from external sources can be supported.
* For performance, the char conversion does not check that every character value is valid. If you want to check that each converted value is a valid code point, use the `is_valid_char` function
* String literals are delimited by double quotes or triple double quotes.
* If you want to extract a character from a string, you index into it: `str[6]`
* All indexing in Julia is 1-based: the first element of any integer-indexed object is found at index 1, and the last element is found at index n, when the string has a length of n.
* In any indexing expression, the keyword `end` can be used as a shorthand for the last index (computed by `endof(str)`).
* You can perform arithmetic and other operations with end, just like a normal value: `str[end-1]`
* Notice that the expressions str[k] and str[k:k] do not give the same result.
* UTF-8 is a variable-width encoding, meaning that not all characters are encoded in the same number of bytes. This means that not every byte index into a UTF-8 string is necessarily a valid index for a character. If you index into a string at such an invalid byte index, an error is thrown.
* Because of variable-length encodings, the number of characters in a string (given by `length(s)`) is not always the same as the last index. If you iterate through the indices 1 through `endof(s)` and index into `s`, the sequence of characters returned when errors aren't thrown is the sequence of characters comprising the string `s`. Thus we have the identity that `length(s) <= endof(s)`, since each character in a string must have its own index.
* You can just use the string as an iterable object, no exception handling required: `for c in s ...`
* Julia also provides `UTF16String` and `UTF32String` types, constructed by the `utf16(s)` and `utf32(s)` functions respectively, for UTF-16 and UTF-32 encodings.
* String concatenation: `string(greet, ", ", whom, ".\n")`
* Julia allows interpolation into string literals using `$`: `"$greet, $whom.\n"`. you can interpolate any expression into a string using parentheses: `"1 + 2 = $(1 + 2)"`
* String functions: `search, repeat, next, ind2char, char2ind`
* Create regular expression: `r"^\s*(?:#|$)"`, or with modifications: `r"a+.*b+.*?d$"ism`
* To check if a regex matches a string, use the ismatch function: `ismatch(r"^\s*(?:#|$)", "not a comment")`
* To capture information about a match, use the match function instead: `match(r"^\s*(?:#|$)", "# a comment")`
* If the regular expression does not match the given string, `match` returns `nothing`
* `nothing` is a special value that does not print anything at the interactive prompt. Other than not printing, it is a completely normal value and you can test for it
* programmatically.
* If a regular expression does match, the value returned by `match` is a `RegexMatch` object. You can extract the following info from a `RegexMatch` object:
    * the entire substring matched: `m.match`
    * the captured substrings as a tuple of strings: `m.captures`
    * the offset at which the whole match begins: `m.offset`
    * the offsets of the captured substrings as a vector: `m.offsets`
* Triple-quoted regex strings, of the form `r"""..."""`, are also supported (and may be convenient for regular expressions containing quotation marks or newlines).
* Version numbers can easily be expressed with non-standard string literals of the form `v"..."`. Version number literals create `VersionNumber` objects.
* `VersionNumber` objects are composed of major, minor and patch numeric values, followed by pre-release and build alpha-numeric annotations. For example, `v"0.2.1-rc1+win64"` is broken into major version 0, minor version 2, patch version 1, pre-release rc1 and build win64.
* The global constant VERSION holds Julia version number as a VersionNumber object.

### Functions
* The basic syntax for defining functions in Julia is: `function f(x,y) \n x + y \n end`.
* There is a second, more terse syntax for defining a function in Julia: `f(x,y) = x + y`.
* In the assignment form, the body of the function must be a single expression, although it can be a compound expression.
* A function is called using the traditional parenthesis syntax.
* Without parentheses, the expression f refers to the function object, and can be passed around like any value.
* The `apply` function applies its first argument — a function object — to its remaining arguments.
* Julia function arguments follow a convention sometimes called “pass-by-sharing”, which means that values are *not* copied when they are passed to functions. Function arguments themselves act as new variable bindings (new locations that can refer to values), but the values they refer to are identical to the passed values. Modifications to mutable values (such as Arrays) made within a function will be visible to the caller.
* The value returned by a function is the value of the last expression evaluated. The `return` Keyword.
* In Julia, most operators are just functions with support for special syntax. The exceptions are operators with special evaluation semantics like `&&` and `||`.
* You can also apply them using parenthesized argument lists, just as you would any other function: `+(1,2,3)`
* The infix form is exactly equivalent to the function application form — in fact the former is parsed to produce the function call internally.
* You can assign and pass around operators such as `+` and `*` just like you would with other function values: `f = +; f(1,2,3)`
* Under the name `f`, the function does not support infix notation, however.
* Operators with special names: 
    * `hcat`: `[A B C ...]`
    * `vcat`: `[A, B, C, ...]`
    * `hvcat`: `[A B; C D; ...]`
    * `ctranspose`: `A’`
    * `transpose`: `A.’`
    * `colon`: `1:n`
    * `getindex`: `A[i]`
    * `setindex!`: `A[i]=x`
* Anonymous function: `x -> x^2 + 2x - 1`
* A zero-argument anonymous function is written as `()->3`.
* In Julia, one returns a tuple of values to simulate returning multiple values. However, tuples can be created and destructured without needing parentheses, thereby providing an illusion that multiple values are being returned, rather than a single tuple value: `function foo(a, b) \n a + b, a * b \n end; x, y = foo(2,3);`
* You can define a varargs function by following the last argument with an ellipsis: `bar(a,b,x...) = (a,b,x)`. `x` is bound to a tuple of the trailing values passed to `bar`.
* On the flip side, it is often handy to “splice” the values contained in an iterable collection into a function call as individual arguments. To do this, one also uses ... but in the function call instead: `bar(1,2,x...)`
* The iterable object spliced into a function call need not be a tuple. Also, the function that arguments are spliced into need not be a varargs function (although it often is).
* Optional arguments: `function parseint(num, base=10)`
* Functions with keyword arguments are defined using a semicolon in the signature: `function plot(x, y; style="solid", width=1, color="black")`
* Extra keyword arguments can be collected using ..., as in varargs functions: `function f(x; y=0, args...)`
* When optional argument default expressions are evaluated, only *previous* arguments are in scope. In contrast, *all* the arguments are in scope when keyword arguments default expressions are evaluated.
* Block syntax: `x -> begin \n .... \n end`
* `do` syntax: `func(args) do x \n ... \n end` -- creates an anonymous function with argument `x` and passes it as the first argument to `func`

### Control Flow
* There are two Julia constructs that accomplish compound expressions: `begin` blocks and `(;)` chains. The value of both compound expression constructs is that of the last subexpression: `z = begin \n x = 1 \n y = 2 \n z =  x + y \n end`, or `z = (x = 1; y = 2; x + y)`
* This syntax is particularly useful with the terse single-line function definition form of functions.
* `if-elseif-else`
* It is an error if the value of a conditional expression is anything but `true` or `false`
* `a ? b : c`
* Short-circuit evaluation is frequently used in Julia to form an alternative to very short if statements.
* `while i <= 5`; `for i = 1:5`
* If the variable `i` has not been introduced in an other scope, in the `for` loop form, it is visible only inside of the `for` loop, and not afterwards.
* `for i in [1,4,0]`
* Multiple nested `for` loops can be combined into a single outer loop, forming the cartesian product of its iterables: `for i = 1:2, j = 3:4`. A `break` statement inside such a loop exits the entire nest of loops, not just the inner one.
* Built-in exceptions: `ArgumentError, BoundsError, DivideError, DomainError, EOFError, ErrorException, InexactError, InterruptException, KeyError, LoadError, MemoryError, MethodError, OverflowError, ParseError, SystemError, TypeError, UndefRefError, UndefVarError`
* `throw(DomainError())`
* The `error` function is used to produce an ErrorException that interrupts the normal flow of control.
* Julia also provides other functions that write messages to the standard error I/O, but do not throw any Exceptions: `info("Hi"); warn("Hi");`
* The exception is much slower than simply comparing and branching.
* `try ... catch e \n if isa(e, DomainError) ... end \n finally ... end`

### Scope of Variables
* Certain constructs in the language introduce scope blocks, including `function` bodies, `while` loops, `for` loops, `try` blocks, `catch` blocks, `let` blocks, `type` blocks.
* Notably missing from this list are `begin` blocks, which do not introduce new scope blocks.
* When a variable is introduced into a scope, it is also inherited by all inner scopes unless one of those inner scopes explicitly overrides it.
* A declaration `local x` or `const x` introduces a new local variable.
* A declaration `global x` makes `x` in the current scope and inner scopes refer to the global variable of that name.
* A function’s arguments are introduced as new local variables into the function’s body scope.
* An assignment `x = y` introduces a new local variable `x` only if `x` is neither declared `global` nor introduced as `local` by any enclosing scope before *or after* the current line of code.
* A variable that is not assigned to or otherwise introduced locally defaults to global.
* Since functions can be used before they are defined, as long as they are defined by the time they are actually called, no syntax for forward declarations is necessary, and definitions can be ordered arbitrarily.
* Anonymous functions are not closures -- the value of their variables are evaluated at run time. To create closures, use `let i = i \n f(i) = () -> i` which copys the current value of `i` to a variable in a new scope which happens to be named `i` too, and bound that `i` to the function.
* `for` loops and comprehensions have a special additional behavior: any new variables introduced in their body scopes are freshly allocated for each loop iteration. 
* The `const` declaration is allowed on both global and local variables, but is especially useful for globals.  If a global variable will not change, adding a `const` declaration solves this performance problem.
* Note that const only affects the variable binding; the variable may be bound to a mutable object (such as an array), and that object may still be modified.

### Types
* Julia’s type system is dynamic, but gains some of the advantages of static type systems by making it possible to indicate that certain values are of specific types.
* The default behavior in Julia when types are omitted is to allow values to be of any type.
* Describing Julia in the lingo of type systems, it is: dynamic, nominative and parametric. 
* One particularly distinctive feature of Julia’s type system is that concrete types may not subtype each other: all concrete types are final and may only have abstract types as their supertypes. 
* There is no division between object and non-object values: all values in Julia are true objects having a type that belongs to a single, fully connected type graph, all nodes of which are equally first-class as types.
* There is no meaningful concept of a “compile-time type”: the only type a value has is its actual type when the program is running. 
* Only values, not variables, have types — variables are simply names bound to values.
* Both abstract and concrete types can be parameterized by other types. They can also be parameterized by symbols, by values of any type for which `isbits` returns `true`.
* The `::` operator can be used to attach type annotations to expressions and variables in programs. 
* When appended to an expression computing a value, the `::` operator is read as “is an instance of”. It can be used anywhere to assert that the value of the expression on the left is an instance of the type on the right. 
* If the type assertion is not true, an exception is thrown, otherwise, the left-hand value is returned.
* When appended to a variable in a statement context, the `::` operator means something a bit different: it declares the variable to always have the specified type, like a type declaration in a statically-typed language such as C. Every value assigned to the variable will be converted to the declared type using the `convert` function.
* Currently, type declarations cannot be used in global scope, e.g. in the REPL, since Julia does not yet have constant-type globals.
* Abstract types cannot be instantiated, and serve only as nodes in the type graph, thereby describing sets of related concrete types: those concrete types which are their descendants. 
*  It is common for a piece of code to make sense, for example, only if its argument*  are some kind of integer, but not really depend on what particular kind of integer.
*  The `abstract` keyword introduces a new abstract type, whose name is given by `«name»`. This name can be  optionally followed by `<:` and an already-existing type, indicating that the newly declared abstract type is a subtype of this “parent” type: `abstract «name» <: «supertype»`
* When no supertype is given, the default supertype is `Any` — a predefined abstract type that all objects are instances of and all types are subtypes of.
* `None` is the exact opposite of `Any`: no object is an instance of `None` and all types are supertypes of `None`.
* The `<:` operator can also be used in expressions as a subtype operator which returns `true` when its left operand is a subtype of its right operand: `Integer <: Number`
* An important point to note is that there is no loss in performance if the programmer relies on a function whose arguments are abstract types, because it is recompiled for each tuple of argument concrete types with which it is invoked. 
* Julia lets you declare your own bits types, rather than providing only a fixed set of built-in bits types: `bitstype 16 Float16 <: FloatingPoint`
* Currently, only sizes that are multiples of 8 bits are supported.
*  In Julia, all values are objects, but functions  are not bundled with the objects they operate on. This is necessary since Julia chooses which method of a function  to use by multiple dispatch, meaning that the types of all of a function’s arguments are considered when selecting a  method, rather than just the first one.
*  Organizing methods into function objects rather than having named bags of methods “inside” each object ends up being a highly beneficial aspect of the language design.
* `type Foo`
* New objects of composite type `Foo` are created by applying the `Foo` type object like a function to values for its fields:  `foo = Foo("Hello, world.", 23, 1.5)`
* When a type is applied like a function it is called a constructor.
* Two constructors are generated automatically (these are called default constructors). One accepts any arguments and calls `convert` to convert them to the types of the fields, and the other accepts arguments that match the field types exactly. 
* You may find a list of field names using the `names` function.
* You can access the field values of a composite object using the traditional `foo.bar` notation:
* Composite types with no fields are singletons; there can be only one instance of such types.
* It is also possible to define immutable composite types by using the keyword `immutable` instead of `type`.
* Such types behave much like other composite types, except that instances of them cannot be modified. Immutable types have several advantages:
    * They are more efficient in some cases. Types like the Complex example above can be packed efficiently into arrays, and in some cases the compiler is able to avoid allocating immutable objects entirely.
    * It is not possible to violate the invariants provided by the type’s constructors.
    * Code using immutable objects can be easier to reason about.
* An immutable object might contain mutable objects, such as arrays, as fields. Those contained objects will remain mutable; only the fields of the immutable object itself cannot be changed to point to different objects.
* In deciding whether to make a type immutable, ask whether two instances with the same field values would be considered identical, or if they might need to change independently over time. If they would be considered identical, the type should probably be immutable.
* An object with an immutable type is passed around (both in assignment statements and in function calls) by copying, whereas a mutable type is passed around by reference.
* It is not permitted to modify the fields of a composite immutable type.
* Composite types, abstract types and bits types are internally represented as instances of the same concept, DataType, which is the type of any of these types: `typeof(Real)`
* Every concrete value in the system is either an instance of some DataType, or is a tuple.
* The type of a tuple of values is the tuple of types of values:
* Accordingly, a tuple of types can be used anywhere a type is expected: `(1,"foo",2.5) :: (Int64,String,Any)`
* Note that the empty tuple `()` is its own type.
* One tuple type is a subtype of another if elements of the first are subtypes of the corresponding elements of the second.
* A type union is a special abstract type which includes as objects all instances of any of its argument types, constructed using the special `Union` function: `IntOrString = Union(Int,String)`
* The union of no types is the “bottom” type, `None`.
* Types can take parameters, so that type declarations actually introduce a whole family of new types.
* All declared types (the `DataType` variety) can be parameterized, with the same syntax in each case. 
* `type Point{T}`
* This single declaration actually declares an unlimited number of types: `Point{Float64}, Point{String}, Point{Int64}`, etc. Each of these is now a usable concrete type.
* `Point` itself is also a valid type object.
* What does `Point` by itself mean? It is an abstract type that contains all the specific instances `Point{Float64}, Point{String}`, etc.: ` Point{Float64} <: Point`
* Even though `Float64 <: Real` we DO NOT have `Point{Float64} <: Point{Real}`.
* This is for practical reasons: while any instance of Point{Float64} may conceptually be like an instance of Point{Real} as well, the two types have different representations in memory:
    * An instance of `Point{Float64}` can be represented compactly and efficiently as an immediate pair of 64-bit values;
    * An instance of `Point{Real}` must be able to hold any pair of instances of `Real`. Since objects that are instances of `Real` can be of arbitrary size and structure, in practice an instance of `Point{Real}` must be represented as a pair of pointers to individually allocated `Real` objects.
* Since the type `Point{Float64}` is a concrete type equivalent to `Point` declared with `Float64` in place of `T`, it can be applied as a constructor accordingly: `Point{Float64}(1.0,2.0)`
* Only one default constructor is generated for parametric types, since overriding it is not possible. This constructor accepts any arguments and converts them to the field types.
* You can also apply `Point` itself as a constructor, provided that the implied value of the parameter type `T` is unambiguous: `Point(1.0,2.0)`
* `abstract Pointy{T}`
* Parametric abstract types are invariant, much as parametric composite types are (all the auto-generated types are siblings): `Pointy{Float64} <: Pointy{Real} #false`
* `type Point{T} <: Pointy{T}`
* Given such a declaration, for each choice of `T`, we have `Point{T}` as a subtype of `Pointy{T}`: `Point{Float64} <: Pointy{Float64}`
* This relationship is also invariant: `Point{Float64} <: Pointy{Real} #false`
* Now both `Point{Float64}` and `DiagPoint{Float64}` are implementations of the `Pointy{Float64}` abstraction, and similarly for every other possible choice of type `T`. This allows programming to a common interface shared by all `Pointy` objects, implemented for both `Point` and `DiagPoint`.
* `abstract Pointy{T<:Real}`
* `type Point{T<:Real} <: Pointy{T}`
* `isa(A,Type{B})` is true if and only if `A` and `B` are the same object and that object is a type.
* Without the parameter, `Type` is simply an abstract type which has all type objects as its instances, including, of course, singleton types: `Float64 <: Type{Float64} <: Type`
* It allows one to specialize function behavior on specific type values. This is useful for writing methods (especially parametric ones) whose behavior depends on a type that is given as an explicit argument rather than implied by the type of one of its arguments.
* `bitstype 32 Ptr{T}`
* The type parameter `T` is not used in the definition of the type itself — it is just an abstract tag, essentially defining an entire family of types with identical structure, differentiated only by their type parameter. Thus, `Ptr{Float64}` and `Ptr{Int64}` are distinct types, even though they have identical representations. And of course, all specific pointer types are subtype of the umbrella `Ptr` type.
* `typealias Uint Uint64`
* `typealias Vector{T} Array{T,1}`
* The `isa` function tests if an object is of a given type and returns `true` or `false`.
* The `typeof` function returns the type of its argument.
* Types are all composite values and thus all have a type of `DataType`
* `DataType` is its own type.
* `super` reveals a type’s supertype. Only declared types (`DataType`) have unambiguous supertypes.

### Methods
* A definition of one possible behavior for a function is called a method.
* When a function is applied to a particular tuple of arguments, the most specific method applicable to those arguments is applied.
* The choice of which method to execute when a function is applied is called dispatch. Julia allows the dispatch process to choose which of a function’s methods to call based on the number of arguments given, and on the types of all of the function’s arguments.
* Multiple dispatch is particularly useful for mathematical code.
* When defining a function, one can optionally constrain the types of parameters it is applicable to, using the `::` type-assertion operator: `f(x::Float64, y::Float64) = 2x + y;`
* Applying it to any other types of arguments will result in a “no method” error.
* To define a function with multiple methods, one simply defines the function multiple times, with different numbers and types of arguments.
* To find out what the signatures of those methods are use the `methods` function.
* In the absence of a type declaration with `::`, the type of a method parameter is `Any` by default, meaning that it is unconstrained since all values in Julia are instances of the abstract type `Any`.
* It is possible to define a set of function methods such that there is no unique most specific method applicable to some combinations of arguments. In such cases, Julia warns you about this ambiguity, but allows you to proceed, arbitrarily picking a method. 
* You should avoid method ambiguities by specifying an appropriate method for the intersection case.
* Method definitions can optionally have type parameters immediately after the method name and before the parameter tuple: `same_type{T}(x::T, y::T) = true;`
* Method type parameters are not restricted to being used as the types of parameters: they can be used anywhere a value would be in the signature of the function or body of the function.
* You can also constrain type parameters of methods: `same_type_numeric{T<:Number}(x::T, y::T) = true`
* Optional arguments are implemented as syntax for multiple method definitions. For example, this definition: `f(a=1,b=2) = a+2b` translates to the following three methods: `f(a,b) = a+2b; f(a) = f(a,2); f() = f(1,2)`
* Methods are dispatched based *only* on positional arguments, with keyword arguments processed *after* the matching method is identified.

### Constructors
* Constructors are functions that create new objects — specifically, instances of Composite Types (page 85). In Julia, type objects also serve as constructor functions.
* `Foo(x) = Foo(x,x)` additional constructor methods declared as normal methods like this are called outer constructor methods. Outer constructor methods can only ever create a new instance by calling another constructor method.
* An inner constructor method is much like an outer constructor method, with two differences:
    * It is declared inside the block of a type declaration, rather than outside of it like normal methods.
    * It has access to a special locally existent function called new that creates objects of the block’s type.
* `type OrderedPair \n x :: Real \n y :: Real \n OrderedPair(x,y) = x > y ? error("out of order") : new(x,y) \n end`
* Once a type is declared, there is no way to add more inner constructor methods. Since outer constructor methods can only create objects by calling other constructor methods, ultimately, some inner constructor must be called to create an object.
* If any inner constructor method is defined, no default constructor method is provided.
* It is considered good form to provide as few inner constructor methods as possible: only those taking all arguments explicitly and enforcing essential error checking and transformation. 
* Additional convenience constructor methods, supplying default values or auxiliary transformations, should be provided as outer constructors that call the inner constructors to do the heavy lifting.
* `Point`, `Point{Float64}` and `Point{Int64}` are all different constructor functions. In fact, `Point{T}` is a distinct constructor function for each type `T`.
* Inner constructor declarations always define methods of `Point{T}` rather than methods of the general `Point` constructor function. Since `Point` is not a concrete type, it makes no sense for it to even have inner constructor methods at all.  It is this method declaration that defines the behavior of constructor calls with explicit type parameters like `Point{Int64}(1,2)` and `Point{Float64}(1.0,2.0)`. 
* The outer constructor declaration, on the other hand, defines a method for the general `Point` constructor which only applies to pairs of values of the same real type. This declaration makes constructor calls without explicit type parameters, like `Point(1,2)` and `Point(1.0,2.5)`, work.
* `convert(Float64,x)`
* `promote(x,y)...`

### Conversion and Promotion
* In a sense, Julia falls into the “no automatic promotion” category: mathematical operators are just functions with special syntax, and the arguments of functions are never automatically converted. 
* “Automatic” promotion of mathematical operands simply emerges as a special application: Julia comes with pre-defined catch-all dispatch rules for mathematical operators, invoked when no specific implementation exists for some combination of operand types. These catch-all rules first promote all operands to a common type using user-definable promotion rules, and then invoke a specialized implementation of the operator in question for the resulting values, now of the same type. 
* User-defined types can easily participate in this promotion system by defining methods for conversion to and from other types, and providing a handful of promotion rules defining what types they should promote to when mixed with other types.
* Conversion of values to various types is performed by the `convert` function. The `convert` function generally takes two arguments: the first is a type object while the second is a value to convert to that type; the returned value is the value converted to an instance of given type: `convert(Uint8, x)`
* Conversion isn’t always possible, in which case a no method error is thrown indicating that `convert` doesn’t know how to perform the requested conversion.
* Julia does not consider parsing strings as numbers or formatting numbers as strings to be conversions.
* To define a new conversion, simply provide a new method for `convert`. That’s really all there is to it. `convert(::Type{Bool}, x::Number) = (x!=0)`
* Notice the syntax used for the first argument: the argument name is omitted prior to the `::` symbol, and only the type is given. This is the syntax in Julia for a function argument whose type is specified but whose value is never used in the function body.
* Promotion has nothing to do with the type hierarchy, and everything to do with converting between alternate representations. For instance, although every `Int32` value can also be represented as a `Float64` value, `Int32` is not a subtype of `Float64`.
* Promotion to a common supertype is performed in Julia by the `promote` function, which takes any number of arguments, and returns a tuple of the same number of values, converted to a common type, or throws an exception if promotion is not possible. 
* The definition of catch-all methods for numeric operations like the arithmetic operators `+`, `-`, `*` and `/`: `+(x::Number, y::Number) = +(promote(x,y)...)`
* The most common usages of promote occur in outer constructors methods, provided for convenience, to allow constructor calls with mixed types to delegate to an inner type with fields promoted to an appropriate common type.
* The behavior of promote is defined in terms of an auxiliary function called `promote_rule`, which one can provide methods for. The `promote_rule` function takes a pair of type objects and returns another type object, such that instances of the argument types will be promoted to the returned type: `promote_rule(::Type{Float64}, ::Type{Float32} ) = Float64`
* The promotion type does not need to be one of the argument types.
* One does not need to define both `promote_rule(::Type{A}, ::Type{B})` and `promote_rule(::Type{B}, ::Type{A})` — the symmetry is implied by the way `promote_rule` is used in the promotion process.
* The `promote_rule` function is used as a building block to define a second function called `promote_type`, which, given any number of type objects, returns the common type to which those values, as arguments to `promote` should be promoted. Thus, if one wants to know, in absence of actual values, what type a collection of values of certain types would promote to, one can use `promote_type`: `promote_type(Int8, Uint16)`

### Modules
* Modules in Julia are separate global variable workspaces. They are delimited syntactically, inside `module Name ... end`. 
* In a module, the `export MyType, foo` statement makes `MyType` and `foo` visible to external modules when they `using` or `import` the current module.
* `using Lib`
* `using BigLib: thing1, thing2` is same as `using BigLib.thing1, BigLib.thing2`
* `import Base`
* `import BigLib: thing1, thing2` is same as `import BigLib.thing1, BigLib.thing2`
* `importall OtherLib` is same as `import OtherLib.thing1, OtherLib.thing2, .(all the exported vars/funcs/types).`
* If only the module name is used or imported, without the `:thing1` or `.thing1`, every types, variables and functions are visible through `ModuleName.var` notation.
* In this case `using` makes exported vars/funcs/types visible without the need of module name, while `import` doesn't.
* In this case all the module's functions are extendable, but only by the `ModuleName.fun` notation.
* If the module is (partly) used or imported by the `:thing1` or `.thing1` notation, or by `importall`, only the explicitly used or imported vars/funcs/types are visible, regardless they are exported or not, without the need of module name, while `ModuleName.var` doesn't work.
* In this case, `import` makes the imported functions extendable, while `using` doesn't.
* Files and file names are mostly unrelated to modules; modules are associated only with module expressions. One can have multiple files per module, and multiple modules per file: `module Foo \n include("file1.jl") \n include("file2.jl") \n end`
* `Main` is the top-level module, and Julia starts with `Main` set as the current module. Variables defined at the prompt go in Main, and `whos()` lists variables in `Main`.
* `Core` contains all identifiers considered “built in” to the language, i.e. part of the core language and not libraries. Every module implicitly specifies `using Core`.
* `Base` is the standard library (the contents of base/). All modules implicitly contain `using Base`.
* Given the statement `using Foo`, the system looks for `Foo` within `Main`. If the module does not exist, the system attempts to `require("Foo")`, which typically results in loading code from an installed package.
* Modules can have submodules. Using a submodule of the current module: `using .Utils`.
* The global variable `LOAD_PATH` contains the directories Julia searches for modules when calling `require`. 
* Extend the `LOAD_PATH` by `push!(LOAD_PATH, "/Path/To/My/Module/")`
* Putting this statement in the file `~/.juliarc.jl` will extend `LOAD_PATH` on every Julia startup. 
* Alternatively, the module load path can be extended by defining the environment variable `JULIA_LOAD_PATH`.

### Multi-dimensional Arrays
* The array library is implemented almost completely in Julia itself, and derives its performance from the compiler, just like any other code written in Julia.*
* In general, unlike many other technical computing languages, Julia does not expect programs to be written in a vectorized style for performance.
* In Julia, all arguments to functions are passed by reference. 
* In Julia, modifications made to input arrays within a function will be visible in the parent function. 
* The entire Julia array library ensures that inputs are not modified by library functions. 
* User code, if it needs to exhibit similar behavior, should take care to create a copy of inputs that it may modify.
* `Array(type, dims...)`: an uninitialized dense array
* `cell(dims...)`: an uninitialized cell array (heterogeneous array)
* `zeros(type, dims...)`: an array of all zeros of specified type, defaults to `Float64` if type not specified
* `zeros(A)`: an array of all zeros of same element type and shape of `A`
* `ones(type, dims...)`: an array of all ones of specified type, defaults to `Float64` if type not specified
* `ones(A)`: an array of all ones of same element type and shape of `A`
* `trues(dims...)`: a Bool array with all values `true`
* `falses(dims...)`: a Bool array with all values `false`
* `reshape(A, dims...)`: an array with the same data as the given array, but with different dimensions.
* `copy(A)`: copy `A`
* `deepcopy(A)`: copy `A`, recursively copying its elements
* `similar(A, element_type, dims...)`: an uninitialized array of the same type as the given array (dense, sparse, etc.), but with the specified element type and dimensions. The second and third arguments are both optional, defaulting to the element type and dimensions of `A` if omitted.
* `reinterpret(type, A)`: an array with the same binary data as the given array, but with the specified element type
* `rand(dims)`: Array of `Float64`s with random, and uniformly distributed values in [0,1)
* `randn(dims)`: Array of `Float64`s with random, and standard normally distributed
* `eye(n)`: `n`-by-`n` identity matrix
* `eye(m, n)`: `m`-by-`n` identity matrix
* `linspace(start, stop, n)`; vector of `n` linearly-spaced elements from `start` to `stop`
* `fill!(A, x)`: fill the array `A` with the value `x`
* `fill(x, dims)`: create an array filled with the value `x`
* `eltype(A)`: the type of the elements contained in `A`
* `length(A)`: the number of elements in `A`
* `ndims(A)`: the number of dimensions of `A`
* `size(A)`: a tuple containing the dimensions of `A`
* `size(A,n)`: the size of `A` in a particular dimension
* `stride(A,k)`: the stride (linear index distance between adjacent elements) along dimension `k`
* `strides(A)`: a tuple of the strides in each dimension
* `cat(k, A...)`: concatenate input `n`-d arrays along the dimension `k`
* `vcat(A...)`: shorthand for `cat(1, A...)`
* `hcat(A...)`: shorthand for `cat(2, A...)`
* `[A B C ...]`: `hcat()`
* `[A, B, C, ...]`: `vcat()`
* `[A B; C D; ...]`: `hvcat()`
* An array with a specific element type can be constructed using the syntax `T[A, B, C, ...]`
* Range: `:`, `a:b`, `a:b:c`. `a=1:3; a.start; a.stop`
* `[1:3]`
* Comprehension: `A = [ F(x,y,...) for x=rx, y=ry, ... ]`. The result is an N-d dense array with dimensions that are the concatenation of the dimensions of the variable ranges `rx`, `ry`, etc. and each `F(x,y,...)` evaluation returns a scalar. `in` could be used in place of `=`.
* The general syntax for indexing into an n-dimensional array `A` is: `X = A[I_1, I_2, ..., I_n]` where each `I_k` may be:
    1. A scalar value
    2. A Range of the form `:`, `a:b`, or `a:b:c`
    3. An arbitrary integer vector, including the empty vector `[]`
    4. A boolean vector
* Trailing dimensions indexed with scalars are dropped.
* Boolean vectors are first transformed with `find`; the size of a dimension indexed by a boolean vector will be the number of true values in the vector.
* Indexing syntax is equivalent to a call to `getindex`: `X = getindex(A, I_1, I_2, ..., I_n)`
* Empty ranges of the form `n:n-1` are sometimes used to indicate the inter-index location between `n-1` and `n`.
* The general syntax for assigning values in an `n`-dimensional array `A` is: `A[I_1, I_2, ..., I_n] = X` where each `I_k` may be:
    1. A scalar value
    2. A Range of the form `:`, `a:b`, or `a:b:c`
    3. An arbitrary integer vector, including the empty vector `[]`
    4. A boolean vector
* Index assignment syntax is equivalent to a call to `setindex!()`: `setindex!(A, X, I_1, I_2, ..., I_n)`
* The following operators are supported for arrays. The dot version of a binary operator should be used for elementwise operations.
    1. Unary arithmetic — `-`, `+`, `!`
    2. Binary arithmetic — `+`, `-`, `*`, `.*`, `/`, `./`, `\\`, `.\\`, `^`, `.^`, `div`, `mod`
    3. Comparison — `.==`, `.!=`, `.<`, `.<=`, `.>`, `.>=`
    4. Unary Boolean or bitwise — `~`
    5. Binary Boolean or bitwise — `&`, `|`, `$`
* Some operators without dots operate elementwise anyway when one argument is a scalar. These operators are `*`, `+`, `-`, and the bitwise operators. The operators `/` and `\\` operate elementwise when the denominator is a scalar.
* Note that comparisons such as `==` operate on whole arrays, giving a single boolean answer. Use dot operators for elementwise comparisons.
* Note that there is a difference between `min()` and `max()`, which operate elementwise over multiple array arguments, and `minimum()` and `maximum()`, which find the smallest and largest values within an array.
* Julia provides the `@vectorize_1arg()` and `@vectorize_2arg()` macros to automatically vectorize any function of one or two arguments respectively. Each of these takes two arguments, namely the Type of argument (which is usually chosen to be the most general possible) and the name of the function to vectorize: `square(x) = x^2; @vectorize_1arg Number square; square([1 2 4; 5 6 7])`
* `repmat(a,1,3)+A`
* Julia offers `broadcast()`, which expands singleton dimensions in array arguments to match the corresponding dimension in the other array without using extra memory, and applies the given function elementwise: `broadcast(+, a, A)`
* Elementwise operators such as `.+` and `.*` perform broadcasting if necessary.
* The base array type in Julia is the abstract type `AbstractArray{T,N}`. It is parametrized by the number of dimensions `N` and the element type `T`.
* Operations on `AbstractArray` objects are defined using higher level operators and functions, in a way that is independent of the underlying storage. These operations generally work correctly as a fallback for any specific array implementation.
* The `AbstractArray` type includes anything vaguely array-like, and implementations of it might be quite different from conventional arrays. 
* `DenseArray` is an abstract subtype of `AbstractArray` intended to include all arrays that are laid out at regular offsets in memory, and which can therefore be passed to external C and Fortran functions expecting this memory layout.
* The `Array{T,N}` type is a specific instance of `DenseArray` where elements are stored in column-major order.
* `SubArray` is a specialization of `AbstractArray` that performs indexing by reference rather than by copying.
* A `SubArray` is created with the `sub()` funtion. The result of `sub()` looks the same as the result of `getindex()`, except the data is left in place: `b = sub(a, 2:2:8,2:2:4)`.

### Networking and Streams
* `write(STDOUT,"Hello World")`
* `read(STDIN,Char)`
* `readbytes(STDIN,4)`
* `readline(STDIN)`
* To read every line from `STDIN` you can use the `eachline` method: `for line in eachline(STDIN)`
* `write(STDOUT,0x61) # a`
* `print(STDOUT,0x61) # 97`
* `f = open("hello.txt")`
* `readlines(f)`
* `f = open("hello.txt","w"); write(f,"Hello again.")`
* The IOStream must be closed before the write is actually flushed to disk: `close(f)`
* Opening a file, doing something to it’s contents, and closing it again is a very common pattern. To make this easier, there exists another invocation of open which takes a function as it’s first argument and filename as it’s second, opens the file, calls the function with the file as an argument, and then closes it again: `function read_and_capitalize(f::IOStream); open(read_and_capitalize, "hello.txt")`
* Or even `open("hello.txt") do f \n uppercase(readall(f)) \n end`

### Date and DateTime
* The `Dates` module provides two types for working with dates: `Date` and `DateTime`, representing day and millisecond precision, respectively; both are subtypes of the abstract TimeType.
* Both `Date` and `DateTime` are basically immutable `Int64` wrappers.
* The `DateTime` type is timezone-unaware.
* Both `Date` and `DateTime` are based on the ISO 8601 standard, which follows the proleptic Gregorian calendar. One note is that the ISO 8601 standard is particular about BC/BCE dates. In general, the last day of the BC/BCE era, 1-12-31 BC/BCE, was followed by 1-1-1 AD/CE, thus no year zero exists. 
* `Date` and `DateTime` types can be constructed by integer or `Period` types, by parsing, or through adjusters.
* Construction using integers: ` DateTime(2013); DateTime(2013,7,1,12); Date(Dates.Year(2013),Dates.Month(7),Dates.Day(1))`
* Parsing and formating string: `dt = DateTime("2014-11-11"); dt = DateTime("20141111", "yyyymmdd"); Dates.format(dt, "yyyy/mm/dd")`
* Comparison and difference: `dt > dt2; dt != dt2; dt - dt2`
* Query: `Dates.year(t); Dates.week(t); Dates.yearmonth(t); Dates.yearmonthday(t); Date.dayofweek(t); Date.isleapyear(t)`
* `Dates.Year(t)`: return `Period` type.
* Next/Prev: `const french_daysofweek = Dict(1=>"Lundi",2=>"Mardi", ... ; Dates.VALUETODAYOFWEEK["french"] = french_daysofweek; Dates.dayname(t;locale="french")`
* Language: `istuesday = x->Dates.dayofweek(x) == Dates.Tuesday; Dates.tonext(istuesday, Date(2014,7,13))`
* Period: `Dates.value(dt2 - dt1)`

### Nullable Types: Representing Missing Values
* Julia provides a parametric type called `Nullable{T}`, which can be thought of as a specialized container type that can contain either zero or one values.
* To construct an object representing a missing value of type `T`, use the `Nullable{T}()` function: `x1 = Nullable{Int}()`
* To construct an object representing a non-missing value of type `T`, use the `Nullable(x::T)` function: `x1 = Nullable(1)`
* You can check if a `Nullable` object has any value using the `isnull` function.
* You can safely access the value of an `Nullable` object using the `get` function: `get(Nullable{Float64}())`. If the value is not present, a `NullException` error will be thrown.
* In cases for which a reasonable default value exists that could be used when a `Nullable` object’s value turns out to be missing, you can provide this default value as a second argument to `get`: `get(Nullable{Float64}(), 0)`

### Interacting With Julia
* When the cursor is at the beginning of the line, the prompt can be changed to a help mode by typing `?`. Julia will attempt to print help or documentation for anything entered in help mode.
* In addition to function names, complete function calls may be entered to see which method is called for the given argument(s). Macros, types and variables can also be queried.
* A semicolon (`;`) will enter the shell mode.
* To initiate an incremental search through the previous history, type ^R — the control key together with the r key. The prompt will change to (reverse-i-search)‘’:, and as you type the search query will appear in the quotes. The most recent result that matches the query will dynamically update to the right of the colon as more is typed. To find an older result using the same query, simply type ^R again. Just as ^R is a reverse search, ^S is a forward search, with the prompt (i-search)‘’:. The two may be used in conjunction with each other to move through the previous or next matching results, respectively.

### Running External Programs
* Julia borrows backtick notation for commands from the shell, Perl, and Ruby: `` `echo hello` ``
* Instead of immediately running the command, backticks create a `Cmd` object to represent the command. You can use this object to connect the command to others via pipes, run it, and read or write to it.
* When the command is run, Julia does not capture its output unless you specifically arrange for it to. Instead, the output of the command by default goes to stdout as it would using libc‘s system call.
* The command is never run with a shell. Instead, Julia parses the command syntax directly, appropriately interpolating variables and splitting on words as the shell would, respecting shell quoting syntax. The command is run as julia‘s immediate child process, using fork and exec calls.
* `` run(`echo hello`) ``
* The `run` method itself returns `nothing`, and throws an `ErrorException` if the external command fails to run successfully.
* If you want to read the output of the external command, the `readall` method can be used instead: `` a=readall(`echo hello`) ``
* You can use `$` for interpolation much as you would in a string literal: `` `sort $file` ``
* The value of `file` is never interpreted by a shell, so there’s no need for actual quoting.
* If you interpolate an array as part of a shell word, Julia emulates the shell’s {a,b,c} argument generation.
* If you interpolate multiple arrays into the same word, the shell’s Cartesian product generation behavior is emulated.
* `` `rm -rf $["foo","bar","baz","qux"].$["aux","log","pdf"]` ``
* Shell metacharacters, such as `|`, `&`, and `>`, are not special inside of Julia’s backticks.
* One uses Julia’s `|>` operator between Cmd objects: `` run(`echo hello` |> `sort`) ``
* Julia itself does the work to setup pipes and connect file descriptors that is normally done by the shell.
* Note that `|>` only redirects `stdout`. To redirect `stderr`, use `.>`
* Julia can run multiple commands in parallel: `` run(`echo hello` & `echo world`) ``
* Julia lets you pipe the output from both of these processes to another program: `` run(`echo world` & `echo hello` |> `sort`) ``
* In terms of UNIX plumbing, what’s happening here is that a single UNIX pipe object is created and written to by both `echo` processes, and the other end of the pipe is read from by the `sort` command.

### Packages
* All package manager commands are found in the `Pkg` module, included in Julia’s Base install.
* The `Pkg.status()` function prints out a summary of the state of packages you have installed. 
* `Pkg.installed()` returns a dictionary, mapping installed package names to the version of that package which is installed.
* Rather than installing a package, you just add it to the list of requirements and then “resolve” what needs to be installed.
* If some package had been installed because it was needed by a previous version of something you wanted, and a newer version doesn’t have that requirement anymore, updating will actually remove that package.
* Your package requirements are in the file `~/.julia/v0.3/REQUIRE`. You can edit this file by hand and then call `Pkg.resolve()` to install, upgrade or remove packages to optimally satisfy the requirements, or you can do `Pkg.edit()`, which will open `REQUIRE` in your editor (configured via the `EDITOR` or `VISUAL` environment variables), and then automatically call `Pkg.resolve()` afterwards if necessary. 
* If you only want to add or remove the requirement for a single package, you can also use the non-interactive `Pkg.add` and `Pkg.rm` commands, which add or remove a single requirement to `REQUIRE` and then call `Pkg.resolve()`
* You can add a package to the list of requirements with the `Pkg.add` function, and the package and all the packages that it depends on will be installed.
* When you decide that you don’t want to have a package around any more, you can use `Pkg.rm` to remove the requirement for it from the `REQUIRE` file.
* `Pkg.edit()` does not roll back the contents of `REQUIRE` if `Pkg.resolve()` fails – rather, you have to run `Pkg.edit()` again to fix the files contents yourself.
* Official Julia packages are registered in the `METADATA.jl` repository, available at [a well-known location](https://github.com/JuliaLang/METADATA.jl)
* The package manager can install and work with unregistered packages too. To install an unregistered package, use `Pkg.clone(url)`, where `url` is a git URL from which the package can be cloned.
* By convention, Julia repository names end with .jl.
* If unregistered packages contain a `REQUIRE` file at the top of their source tree, that file will be used to determine which registered packages the unregistered package depends on, and they will automatically be installed.
* To get the latest and greatest versions of all your packages, just do `Pkg.update()`.

### Performance Tips

### Style Guide

### Noteworthy Differences from other Languages
