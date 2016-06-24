# repqlite

Replicating SQLite through monitoring filesystem events.

### Usage
```
Usage: ./repqlite [options] PATH
PATH - The path to the databases directory.
Options:
  sqldiff:
   -L|--lib LIBRARY   Load an SQLite extension library
   --primarykey       Use schema-defined PRIMARY KEYs
   --rbu              Output SQL to create/populate RBU table(s)
   --transaction      Show SQL output inside a transaction
  replicator:
   --event EVENT      Catch filesystem event: close_write|modify
                      Default: close_write
   --verbose          Verbose output
```

### System requirements
* Linux kernel >= 2.6.21
* SQLite >= 3.8.10

### License
[Public Domain](https://en.wikipedia.org/wiki/Public_domain)
