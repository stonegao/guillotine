
require "rubygems"
require "activerecord"
require File.dirname(__FILE__) + "/cache_model/cached_model"
require File.dirname(__FILE__) + "/cache_model/converters"
require File.dirname(__FILE__) + "/cache_model/active_record"

require "treetop"
Treetop.load File.dirname(__FILE__) + "/cache_model/treetop/sql_select"


