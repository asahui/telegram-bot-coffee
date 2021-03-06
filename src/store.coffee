# Variables storage for multi processing
{config} = require './launcher'
Memcached = require 'memcached'

cache = new Memcached config.memcached,
  retries: 10,
  algorithm: 'md5',
  timeout: 1500,
  reconnect: 2000

lifetime = 5 * 60 * 60

key = (type, id) ->
  "#{config.name}:#{type}:#{id}"

exports.put = (type, id, value, callback) ->
  cache.set (key type, id), value, lifetime, callback

exports.get = (type, id, callback) ->
  cache.get (key type, id), callback

