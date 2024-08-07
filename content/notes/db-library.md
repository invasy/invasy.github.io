---
title: DB model of a library
categories:
- interview
tags:
- database
- SQL
- model
draft: true
---
# Problem

Define a model of a library.

## Requirements

- 3 entities:
  - book
  - author
  - reader
- all books are unique
- book can be read by 1 or 0 readers only

# Model

```sql
CREATE TABLE IF NOT EXISTS readers (
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(64) NOT NULL
)

CREATE TABLE IF NOT EXISTS authors (
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(64) NOT NULL
)

CREATE TABLE IF NOT EXISTS books (
    id INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
    title TEXT NOT NULL,
    reader_id INTEGER,
    FOREIGN KEY(reader_id) REFERENCES readers(id) ON DELETE SET NULL
)

CREATE TABLE IF NOT EXISTS book_authors (
    book_id INTEGER REFERENCES books(id) ON DELETE CASCADE,
    author_id INTEGER REFERENCES authors(id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, author_id)
)
```

# Requests

1. Select all the books that are being read now:
    ```sql
    SELECT title
    FROM books
    WHERE reader_id IS NOT NULL
    ORDER BY title;
    ```
2. Select all the books with 3 or more authors:
    ```sql
    SELECT books.title
    FROM book_authors
        JOIN books ON book_authors.book_id = books.id
        JOIN authors ON book_authors.author_id = authors.id
    GROUP BY books.id
    HAVING count(*) > 3
    ORDER BY books.title;
    ```
3. Select 3 the most readable authors:
    ```sql
    SELECT authors.name
    FROM book_authors
        JOIN books ON book_authors.book_id = books.id
        JOIN authors ON book_authors.author_id = authors.id
    WHERE books.reader_id IS NOT NULL
    GROUP BY authors.id
    ORDER BY COUNT(*) DESC
    LIMIT 3;
    ```
