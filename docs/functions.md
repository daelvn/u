# Functions

| Function | Description |
| -- | -- |
| **Tables** | |
| [each](#each) | Iterates over a table without keeping values. |
| [map](#map) | Produces a new table by iteratung with a function. |
| [reduce](#reduce) | Boils down a list of values into a single one. |
| [reduceRight](#reduceright) | Right-associative version of [reduce](#reduce). |
| [find](#find) | Returns the first value in a list that passes a predicate. |
| [filter](#filter) | Returns all values in a list that pass a predicate. |
| [findWhere](#findwhere) | Combination of [find](#find) and [matcher](#matcher). |
| [where](#where) | Combination of [filter](#filter) and [matcher](#matcher). |
| [reject](#reject) | Opposite of [filter](#filter). |
| [every](#every) | Checks that all values pass a predicate. |
| [some](#some) | Checks that any value passes a predicate. |
| [contains](#contains) | Check if a list contains an item. |
| [invoke](#invoke) | Calls a method on every value. |
| [pluck](#pluck) | Extracts a list of property values. |
| [max](#max) | Returns the maximum value in a list. |
| [min](#min) | Returns the minimum value in a list. |
| [sortBy](#sortby) | Returns a sorted copy of a list. |
| [groupBy](#groupby) | Splits a collection into sets defined by an iteratee. |
| [indexBy](#indexby) | [groupBy](#groupby) with unique keys. |
| [countBy](#countby) | Returns the length of each group made by [groupBy](#groupby). |
| [shuffle](#shuffle) | Shuffles a list. |
| [sample](#sample) | Returns a `n` random elements from a list. |
| [size](#size) | Counts the elements in a table. |
| [partition](#partition) | [filter](#filter) and [reject](#reject) simultaneously. |
| [compact](#compact) | Returns a copy of the list with all *falsy* values removed. |
| **Arrays** | |
| [first](#first) | Gets the `n` first elements of an array. |
| [initial](#initial) | Gets all elements of an array except the `n` last. |
| [last](#last) | Gets the `n` last elements of an array. |
| [rest](#first) | Gets all elements of an array except the `n` first. |
| [flatten](#flatten) | Flattens a nested array. |
| [without](#without) | Returns a copy of the array with values removed. |
| [union](#union) | Joins several arrays. |
| [intersection](#intersection) | Lists the values that intersect in all arrays. |
| [difference](#difference) | Opposite of [intersection](#intersection). |
| [uniq](#uniq) | Removes duplicates from an array. |
| [zip](#zip) | Merges several arrays with values at corresponding places. |
| [unzip](#unzip) | Opposite of [zip](#zip) |
| [intersperse](#intersperse) | Interlace the values of two arrays. |
| [chunk](#chunk) | Splits an array into several arrays of `n` length. |
| [indexOf](#indexof) | Returns the index at which a value can be found in an array. |
| [lastIndexOf](#lastindexof) | Last occurrence of value in the array. |
| [sortedIndex](#sortedindex) | Returns the smallest index for a value to be inserted. |
| [findIndex](#findindex) | Returns the first index where the predicate passes. |
| [findLastIndex](#findlastindex) | Returns the last index where the predicate passes. |
| [range](#range) | A function to create lists of integers, ranges. |
| **Checks** | |
| [isList](#islist) | Checks that a table only has numeric indexes. |
| [isMap](#ismap) | Opposite of [isList](#islist). |
| **Utility** | |
| [identity](#identity) | Returns the values passed. |
| [constant](#constant) | Returns a function that returns the values passed. |
| [iteratee](#iteratee) | Shorthand for iteratees. |
| [matcher](#matcher) | Checks the shape of a table. |
| [copy](#copy) | Deep copies a table. |
| [clone](#clone) | Shallow clones a table. |

## Tables

Functions that are applied on tables.

### each

**Alias:** `forEach`

`each (t:table, ((value:any, key:any, t:table) -> nil)) -> t:table`

Iterates over a table, yielding each in turn to an **iteratee** function. Each invocation of **iteratee** is called with three arguments: `(element:any, index:any, list:table)`. If list is a [map](tables#maps), The **iteratee**'s arguments will be `(value, key, list)`. Returns the table.

<!-- tabs:start -->

#### **Lua**

```lua
u.each({1, 2, 3}, function(x) print(x) end)
--> 1
--> 2
--> 3
u.each({a=1, b=2, c=3}, function(x) print(x) end)
--> 1
--> 2
--> 3
```

#### **MoonScript**

```moon
u.each {1, 2, 3}, (x) -> print x
--> 1
--> 2
--> 3
u.each {a: 1, b: 2, c: 3}, (x) -> print x
--> 1
--> 2
--> 3
```

<!-- tabs:end -->

### map

**Alias:** `collect`

`map (t:table, ((value:any, key:any, t:table) -> nil)) -> t:table`

Produces a new array of values by mapping each value in `t` through a transformation function (iteratee). The iteratee is passed three arguments: the `value`, then the index (or `key`) of the iteration, and finally a reference to the entire table (`t`).

<!-- tabs:start -->

#### **Lua**

```lua
u.map({1, 2, 3}, function(x) x + 1 end)
--> {2, 3, 4}
u.map({a=1, b=2, c=3}, function(x) x + 1 end)
--> {a=2, b=3, c=4}
```

#### **MoonScript**

```moon
u.map {1, 2, 3}, (x) -> x + 1
--> {2, 3, 4}
u.map {a: 1, b: 2, c: 3}, (x) ->  x + 1
--> {a: 2, b: 3, c: 4}
```

<!-- tabs:end -->

### reduce

**Aliases:** `inject`, `foldl`

`reduce (t:table, ((memo:any, value:any, key:any, t:table) -> any), memo:any?) -> any`

Also known as *inject* and *foldl*, reduce boils down a [list](tables#lists) of values into a single value. `memo` is the initial state of the reduction, and each successive step of it should be returned by the iteratee. The iteratee is passed four arguments: the `memo`, then the `value` and index (or `key`) of the iteration, and finally a reference to the entire list (`t`).

If no `memo` is passed to the initial invocation of reduce, the iteratee is not invoked on the first element of the list. The first element is instead passed as the memo in the invocation of the iteratee on the next element in the list.

<!-- tabs:start -->

#### **Lua**

```lua
u.reduce({1, 2, 3}, function(memo, num) return memo + num end)
--> 6
```

#### **MoonScript**

```moon
u.reduce {1, 2, 3}, (memo, num) -> memo + num
--> 6
```

<!-- tabs:end -->

### reduceRight

**Alias:** `foldr`

`reduceRight (t:table, ((memo:any, value:any, key:any, t:table) -> any), memo:any?) -> any`

The right-associative version of reduce. Foldr is not as useful in Lua as it would be in a language with lazy evaluation.

<!-- tabs:start -->

#### **Lua**

```lua
u.reduceRight({{0,1}, {2,3}, {4,5}}, function(a, b) return u.join(a, b) end)
--> {4, 5, 2, 3, 0, 1}
```

#### **MoonScript**

```moon
u.reduce {{0,1}, {2,3}, {4,5}}, (a, b) -> u.join(a, b)
--> {4, 5, 2, 3, 0, 1}
```

<!-- tabs:end -->

### find

**Alias:** `detect`

`find (t:table, predicate:function) -> any`

Looks through each value in the [list](tables#lists), returning the first one that passes a truth test (`predicate`), or `nil` if no value passes the test. The function returns as soon as it finds an acceptable element, and doesn't traverse the entire list. `predicate` is transformed through [u.iteratee](#iteratee) to facilitate shorthand syntaxes.

<!-- tabs:start -->

#### **Lua**

```lua
u.find({1, 2, 3, 4, 5, 6}, function(num) return num % 2 == 0 end)
--> 2
```

#### **MoonScript**

```moon
u.find {1, 2, 3, 4, 5, 6}, (num) -> num % 2 == 0
--> 2
```

<!-- tabs:end -->

### filter

**Alias:** `select`

`filter (t:table, predicate:function) -> any`

Looks through each value in the [list](tables#lists), returning all that pass a truth test (`predicate`), or `nil` if no value passes the test. `predicate` is transformed through [u.iteratee](#iteratee) to facilitate shorthand syntaxes.

<!-- tabs:start -->

#### **Lua**

```lua
u.filter({1, 2, 3, 4, 5, 6}, function(num) return num % 2 == 0 end)
--> {2, 4, 6}
```

#### **MoonScript**

```moon
u.find {1, 2, 3, 4, 5, 6}, (num) -> num % 2 == 0
--> {2, 4, 6}
```

<!-- tabs:end -->

### findWhere

`findWhere (t:table, properties:table) -> any`

Looks through the [list](tables#list) and returns the first value that matches all of the key-value pairs listed in `properties`.

If no match is found, or if `t` is empty, `nil` will be returned.

<!-- tabs:start -->

#### **Lua**

```lua
u.findWhere(publicServicePulitzers, {newsroom = "The New York Times"})
--> {year=1918, newsroom="The New York Times",
-->  reason="For its public service in publishing in full so many official reports,
-->  documents and speeches by European statesmen relating to the progress and
-->  conduct of the war."}
```

#### **MoonScript**

```moon
u.findWhere publicServicePulitzers, newsroom: "The New York Times"
--> {year: 1918, newsroom: "The New York Times",
-->  reason: "For its public service in publishing in full so many official reports,
-->  documents and speeches by European statesmen relating to the progress and
-->  conduct of the war."}
```

<!-- tabs:end -->

### where

`where (t:table, properties:table) -> any`

Looks through each value in the [list](tables#list), returning an [array](tables#arrays) of all the values that matches the key-value pairs listed in `properties`.

<!-- tabs:start -->

#### **Lua**

```lua
u.where(listOfPlays, {author = "Shakespeare", year = 1611})
--> {{title="Cymbeline",   author="Shakespeare", year=1611},
-->  {title="The Tempest", author="Shakespeare", year=1611}}
```

#### **MoonScript**

```moon
u.where listOfPlays, {author: "Shakespeare", year: 1611}
--> {{title: "Cymbeline",   author: "Shakespeare", year: 1611},
-->  {title: "The Tempest", author: "Shakespeare", year: 1611}}
```

### reject

`reject (t:table, predicate:function) -> any`

Returns the values in `t` without the elements that the truth test (`predicate`) passes. The opposite of [filter](#filter). predicate is transformed through [u.iteratee](#iteratee) to facilitate shorthand syntaxes.

<!-- tabs:start -->

#### **Lua**

```lua
u.reject({1, 2, 3, 4, 5, 6}, function(num) return num % 2 == 0 end)
--> {1, 3, 5}
```

#### **MoonScript**

```moon
u.reject {1, 2, 3, 4, 5, 6}, (num) -> num % 2 == 0
--> {1, 3, 5}
```

<!-- tabs:end -->

### every

**Alias:** `all`

`every (t:table, predicate:function) -> boolean`

Returns `true` if all of the values in the [list](tables#lists) pass the `predicate` truth test. Short-circuits and stops traversing the list if a false element is found. predicate is transformed through [u.iteratee](#iteratee) to facilitate shorthand syntaxes.

<!-- tabs:start -->

#### **Lua**

```lua
u.every({2, 4, 5}, function(num) return num % 2 == 0 end)
--> false
```

#### **MoonScript**

```moon
u.every {2, 4, 5}, (num) -> num % 2 == 0
--> false
```

<!-- tabs:end -->

### some

**Alias:** `any`

`any (t:table, predicate:function) -> boolean`

Returns `true` if any of the values in the list pass the `predicate` truth test. Short-circuits and stops traversing the list if a true element is found. `predicate` is transformed through [u.iteratee](#iteratee) to facilitate shorthand syntaxes.

<!-- tabs:start -->

#### **Lua**

```lua
u.some({2, 4, 5}, function(num) return num % 2 == 0 end)
--> true
```

#### **MoonScript**

```moon
u.some {2, 4, 5}, (num) -> num % 2 == 0
--> true
```

<!-- tabs:end -->

### contains

**Aliases:** `include`, `includes`

`contains (t:table, value:any) -> boolean`

Returns `true` if the value is present in `t`. 

<!-- tabs:start -->

#### **Lua**

```lua
u.contains({2, 4, 5}, 4)
--> true
```

#### **MoonScript**

```moon
u.contains {2, 4, 5}, 4
--> true
```

<!-- tabs:end -->

### invoke

**Alias:** `call`

`invoke (t:table, method:string, ...) -> t:table`

Calls the method named by `method` on each value in the list. Any extra arguments passed to `invoke` will be forwarded on to the method invocation.

Equivalent to `for k, v in pairs t do v[method] v, ...`.

<!-- tabs:start -->

#### **Lua**

```lua
u.invoke({"a", "b"}, "upper")
--> {"A", "B"}
```

#### **MoonScript**

```moon
u.invoke {"a", "b"}, "upper"
--> {"A", "B"}
```

<!-- tabs:end -->

### sortBy

**Alias:** `sort`

`sortBy (t:table, comparator:function) -> table`

!> This function is implemented differently from the underscore.js function.

Returns a sorted copy of `t`. A comparison function can be provided to customise the element sorting. The comparison function must return a boolean value specifying whether the first argument should be before the second argument in the sequence. The default behaviour is for the `<` (ascendent) comparison to be made.

Wrapper around Lua's `table.sort`.

<!-- tabs:start -->

#### **Lua**

```lua
u.sortBy({3, 2, 1})
--> {1, 2, 3}
```

#### **MoonScript**

```moon
u.sortBy {3, 2, 1}
--> {1, 2, 3}
```

<!-- tabs:end -->

## Arrays

### first

**Aliases:** `head`, `take`

`first (t:table, n:number?) -> ...:any`

Gets the `n` first elements of a list. `n` defaults to 1.

### initial

**Alias:** `init`

`initial (t:table, n:number?) -> table`

Gets all elements of a list except the `n` last. `n` defaults to 1.

### last

`last (t:table, n:number?) -> ...:any`

Gets the `n` last elements of a list. `n` defaults to 1.

### rest

**Aliases:** `tail`, `drop`

`rest (t:table, n:number?) -> table`

Gets all elements of a list except the `n` first. `n` defaults to 1.

## Checks

### isList

**Alias:** `isArray`

`isList (t:table) -> boolean`

Returns true if `t` is a [list](tables#lists).

### isMap

**Alias:** `isObject`

`isList (t:table) -> boolean`

Returns true if `t` is a [map](tables#maps).

## Utility

### identity

**Alias:** `id`

`identity (...) -> ...`

Returns the same value that is used as the argument. In math: `f x = x`
This function looks useless, but is used throughout u as a default iteratee.

### constant

**Alias:** `const`

`constant (...) -> -> ...`

Creates a function that returns the same value that is used as the argument of `u.constant`.

### iteratee

`iteratee (value:any) -> function`

Generates a callback that can be applied to each element in a collection. `u.iteratee` supports a number of shorthand syntaxes for common callback use cases. Depending upon value's type, `u.iteratee` will return:

<!-- tabs:start -->

#### **Lua**

```lua
-- No value
u.iteratee()
--> u.identity()

-- Function
u.iteratee(function(x) return x end)
--> function(x) return x end

-- Table
u.iteratee({firstName = "Chelsea"})
--> u.matcher({firstName = "Chelsea"})

-- Anything else
u.iteratee("firstName")
--> u.property("firstName")
```

#### **MoonScript**

```moon
-- No value
u.iteratee!
--> u.identity!

-- Function
u.iteratee (x) -> x
--> (x) -> x

-- Table
u.iteratee firstName: "Chelsea"
--> u.matcher {firstName: "Chelsea"}

-- Anything else
u.iteratee "firstName"
--> u.property "firstName"
```

<!-- tabs:end -->

### matcher

**Alias:** `matches`

`matcher (attrs:table) -> (checked:table) -> boolean`

Returns a predicate function that will tell you if a passed in [object](tables#objects) contains all of the key/value properties present in `attrs`.

<!-- tabs:start -->

#### **Lua**

```lua

```

#### **MoonScript**

```moon

```

<!-- tabs:end -->