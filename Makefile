# repqlite - a tiny SQLite replication utility.

CC = gcc

CFLAGS = -O2
CFLAGS+= -Wall -Werror -Wextra -Wshadow
CFLAGS+= -fno-strict-aliasing

LIBS = -lsqlite3

SQL_SCHEMA = "\
    CREATE TABLE person (id INTEGER NOT NULL PRIMARY KEY, name TEXT, age INTEGER);\
    INSERT INTO  person VALUES (NULL, 'Alexey', 26);\
    INSERT INTO  person VALUES (NULL, 'Mihail', 27);\
    INSERT INTO  person VALUES (NULL, 'Ivan',   28);\
    INSERT INTO  person VALUES (NULL, 'Nick',   29);"

EVENT = close_write

all: options repqlite

options:
	@echo \* repqlite build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LIBS     = ${LIBS}"
	@echo "CC       = ${CC}"
	@echo

repqlite:
	@echo \* CC -o $@
	$(CC) $(CFLAGS) $(LIBS) -o $@ $@.c

run:
	./repqlite --event $(EVENT) -v t/db

test: create_dirs create_databases create_backups
	@echo \* creating data for testing

create_dirs:
	@mkdir -p t/db/{backup,patches,schemas,orig-old}

create_databases:
	@echo -e $(SQL_SCHEMA) > t/db/schemas/schema.sql
	@sqlite3 t/db/test.db < t/db/schemas/schema.sql

create_backups:
	@cp t/db/*.db t/db/backup
	@cp t/db/*.db t/db/orig-old

clean:
	@echo \* cleaning
	@rm -rf repqlite t
