= Guillotine 

* FIX (url)

== DESCRIPTION:

Provide transparent, row level cache to ActiveRecord.

== FEATURES/PROBLEMS:

* FIX (list of features or problems)

== SYNOPSIS:

Philosophical problems to current caching 

schemes available to ActiveRecord:

==========================================

1.  Rails Query cache is dead simple.  It's great, but it only caches 
    queries per request.  At the start of a new request, the cache
    is invalidated.

2.  Memcached: cached_model, acts_as_cached, etc..  This works on a time basis
    (expiring automatically after X minutes).  Works great, except that
    you'll need to modify your code to use it - in no way is it transparent.  
    If you want to perform these two queries in two seperate
    places:

        User.find(:all, :limit => 10)

        User.find(:all, :limit => 20)
    
    You'll either need to write the logic to grab the first 10 from the cache
    for the second query, or you'll need to store both sets of records in 
    memcached.  Storing the whole table in one memcached key/value pair is impossible
    if your table goes over 1 meg (which it will).  Otherwise, unique naming schemes
    need to be devised for the cache.  The records will also get invalidated
    even if you don't update them, causing a new fetch every X minutes.

    Time based cache expiry is great for caching html fragments, and *should*
    be used on top of this plugin.  

3.  Mysql has it's own query cache, which works great for sites which are
    90% (or more) reads to writes.  The cache is per table, and gets invalidated
    as soon as any write is performed to the table.  For larger tables this means
    removing the cache (for the whole table!) from memory, only to recreate
    it.  Further, the query cache cannot be turned on per-table, which just
    seems silly.


Solution

==============

Use Guillotine, which means that the table can stay in memory as long as 
you use ActiveRecord's standard methods to read and write from the table.

The cache is row level, so any time an individual row is written to it not
only gets written to the database, but also updated in the cache.

No extra work is needed!  Your code will not need to change one bit.


Specs / Tests

==============

Integration tests *should* hit the database, but a large test suite which hits
the database often will really kill the performance of that suite, which will 
cause tests to either be run less frequently, leading to hard to track down bugs,
or just as frequently as before, but with decreased productivity.  

Some have used sqlite's in memory test database to speed up their suite.  I've
seen a 40-50% improvement on a larger suite before.  Unfortunately, an in memory
database is not always an option; If any custom sql is present, a sqlite in memory test
database will be out of the question.  Guillotine will allow use of it's cache
for in memory tests without writing to a real database.


Limitations

==============

At this time, there are only plans to support Mysql 5, and possibly SQLite.

== REQUIREMENTS:

See DEPENDENCIES

== INSTALL:

* FIX (sudo gem install, anything else)

== LICENSE:

(None, yet)



