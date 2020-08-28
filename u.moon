-- u
-- A port of underscore.js
inspect = require "inspect"

u = {}

-- each, forEach
u.each = (t, fn) ->
  if u.isList t
    fn v, i, t for i, v in ipairs t
  elseif u.isMap t
    fn v, k, t for k, v in pairs t
  --
  return t
u.forEach = u.each

-- map, collect
u.map = (t, fn) ->
  if u.isList t
    return [fn v, i, t for i, v in ipairs t]
  elseif u.isMap t
    return {k, (fn v, k, t) for k, v in pairs t}
u.collect = u.map

-- reduce, inject, foldl
u.reduce = (t, fn, memo) -> u.foldr (u.tail t), fn, (u.head t)
u.inject = u.reduce
u.foldl  = u.reduce

-- reduceRight, foldr
u.reduceRight = (t, fn, memo) ->
  print (inspect t), fn, (inspect memo)
  for k, v in pairs t
    memo = fn memo, v, k, t
  return memo
u.foldr = u.reduceRight

-- find, detect
u.find = (t, predicate) ->
  pred = u.iteratee predicate
  for k, v in pairs t
    return v if pred v
u.detect = u.find

-- filter, select
u.filter = (t, predicate) ->
  pred = u.iteratee predicate
  coll = {}
  for k, v in pairs t
    table.insert coll, v if pred v
  return (#coll > 0) and coll or nil

-- findWhere
u.findWhere = (t, properties) ->
  pred = u.matcher properties
  for k, v in pairs t
    return v if pred v
  return nil

-- where
u.where = (t, properties) ->
  pred = u.matcher properties
  coll = {}
  for k, v in pairs t
    table.insert coll, v if pred v
  return (#coll > 0) and coll or nil

-- reject
u.reject = (t, predicate) ->
  pred = u.iteratee predicate
  coll = {}
  for k, v in pairs t
    table.insert coll, v unless pred v
  return (#coll > 0) and coll or nil

-- every, all
u.every = (t, predicate) ->
  pred = u.iteratee predicate
  for k, v in pairs t
    return false unless pred v
  return true
u.all = u.every

-- some, any
u.some = (t, predicate) ->
  pred = u.iteratee predicate
  for k, v in pairs t
    return true if pred v
  return false
u.any = u.some

-- contains, include, includes
u.contains = (t, value) ->
  for k, v in pairs t
    return true if v == value
  return false
u.include  = u.contains
u.includes = u.contains

-- invoke, call
u.invoke = (t, method, ...) ->
  for k, v in pairs t do t[k] = v[method] v, ...
  return t
u.call = u.invoke

-- pluck
u.pluck = (t, property) -> u.map t, (v) -> v[property]

-- max, maximum
u.max = (t, iteratee=u.identity) ->
  max = -math.inf
  for k, v in pairs t
    max = iteratee v, k, t if v > max
  return max
u.maximum = u.max

-- min, minimum
u.min = (t, iteratee=u.identity) ->
  min = math.inf
  for k, v in pairs t
    min = iteratee v, k, t if v < min
  return min
u.minimum = u.min

-- sortBy, sort
u.sortBy = (t, comparator) ->
  cpy = u.copy t
  table.sort cpy, comparator
  return cpy
u.sort = u.sortBy

-- groupBy, group
u.groupBy = (t, fn) ->
  res = {}
  for k, v in pairs t
    fnv = fn v
    res[fnv] or= {}
    table.insert res[fnv], v
  return res
u.group = u.groupBy

-- indexBy
u.indexBy = (t, fn) ->
  res = {}
  for k, v in pairs t
    res[fn v] = v
  return res

-- countBy
u.countBy = (t, fn) ->
  res = {}
  for k, v in pairs t
    fnv = fn v
    res[fnv] or= 0
    res[fnv]  += 1
  return res

-- shuffle
math.randomseed os.time!
u.shuffle = (t) ->
  cpy = u.copy t
  for i=#t, 1, -1
    j      = math.random 1, i
    e      = cpy[i]
    cpy[i] = cpy[j]
    cpy[j] = e
  return cpy

-- sample
u.sample = (t, n) -> u.head (u.shuffle t), n

-- size
u.size = (t) ->
  count  = 0
  count += 1 for k, v in pairs t
  return count

-- partition
u.partition = (t, predicate) ->
  pred       = u.iteratee predicate
  colt, colf = {}, {}
  for k, v in pairs t
    if pred v
      table.insert colt, v
    else
      table.insert colf, v
  return colt, colf

-- compact
u.compact = (t) -> {k, v for k, v in pairs t when v}

-- TODO make u.join for tables
-- TODO make u.splice for tables

-- first, head, take
u.first = (t, n=1) -> unpack [e for i, e in ipairs t when i <= n]
u.head  = u.first
u.take  = u.first

-- initial, init
u.initial = (t, n=1) -> [e for i, e in ipairs t when i <= #t-n]
u.init    = u.initial

-- last
u.last = (t, n=1) -> unpack [e for i, e in ipairs t when i > #t-n]

-- rest, tail, drop
u.rest = (t, n=1) -> [e for i, e in ipairs t when i > n]
u.tail = u.rest
u.drop = u.rest

-- flatten
u.flatten = (t) ->
  if "table" != type t then return {t}
  flat = {}
  for elem in *t
    for val in *u.flatten elem
      table.insert flat, val
  return flat

-- without
u.without = (t, ...) -> [v for i, v in ipairs t when not u.contains {...}, v]

-- union
u.union = (...) ->
  total = {}
  for t in *{...}
    for v in *t
      table.insert total, v
  return total

-- intersection
u.intersection = (...) -> -- TODO implement intersection

-- difference
u.difference = (t, ...) -> -- TODO implement difference

-- isList, isArray
u.isList = (t) ->
  for k, v in pairs t do return false if "number" != type k
  return true
u.isArray = u.isList

-- isMap, isObject
u.isMap    = (t) -> not u.isList t
u.isObject = u.isMap

-- iteratee
u.iteratee = (a) -> return switch type a
  when "nil"      then u.identity
  when "function" then a
  when "table"    then u.matcher a
  else                 u.property a

-- matcher, matches
u.matcher = (t) -> (ch) ->
  for k, v in pairs t do return false unless ch[k] and ch[k] == v
  return true
u.matches = u.matcher

-- identity, id
u.identity = (...) -> ...
u.id       = u.identity

-- constant, const
u.constant = (...) ->
  args = {...}
  -> unpack args
u.const    = u.constant

-- copy
u.copy = (t) ->
  switch type t
    when "table"
      copy = {}
      for k, v in next, t, nil do copy[u.copy k] = u.copy v
      setmetatable copy, u.copy getmetatable t
    else
      copy = t
  return t

-- clone
u.clone = (t) -> {k, v for k, v in pairs t}

--print inspect u.intersection {1, 2, 3}, {101, 2, 1, 10}, {2, 1}