---
title: Technical interview questions
categories:
- interview
tags:
- C++
- database
- SQL
draft: true
---
# C++
- [ ] Type casting:
  - [ ] `static_cast`
  - [ ] `const_cast`
  - [ ] `reinterpret_cast`
- [ ] Smart pointers:
  - [ ] `std::unique_pointer`
  - [ ] `std::shared_pointer`
  - [ ] `std::weak_pointer`
- [ ] STL containers:
  - [ ] `std::array`
  - [ ] `std::vector`
  - [ ] `std::deque`
  - [ ] `std::map`
  - [ ] `std::unordered_map`
  - [ ] `std::set`
  - [ ] `std::unordered_set`
  - [ ] `std::stack`
  - [ ] `std::queue`
  - [ ] `std::priority_queue`
  - [ ] list
  - [ ] span
- [ ] Exceptions:
  - [ ] try, catch, finally
  - [ ] stack unwinding
- [ ] `noexcept`
- [ ] `volatile`
- [ ] Inheritance
- [ ] Virtual destructor
- [ ] `struct` vs `class`
- [ ] virtual functions
- [ ] pure virtual functions
- [ ] vtable
- [ ] lvalue, rvalue
- [ ] perfect forwarding
- [ ] move semantics
- [ ] reference vs pointer
- [ ] `new` vs `malloc`
- [ ] `new` and `new[]`
- [ ] `delete` and `delete[]`
- [ ] polymorphism: compile-time vs runtime
- [ ] constructors:
  - [ ] default
  - [ ] parameterized
  - [ ] move
  - [ ] copy
- [ ] destructor overloading
- [ ] friend classes and functions
- [ ] recursive inline function?
- [ ] `inline`
- [ ] `static`
- [ ] abstract class
- [ ] storage class
- [ ] `mutable`
- [ ] `auto`
- [ ] namespaces
- [ ] anonymous namespace
- [ ] Can we call a virtual function from a constructor?
  - Yes, we can call a virtual function from a constructor. But it can throw an exception of overriding.
- [ ] anatomy of a class, memory layout
- [ ] size of an empty class
- [ ] `this` pointer
- [ ] lambdas
- [ ] function overloading
- [ ] concurrency:
  - [ ] thread and jthread
  - [ ] future, promise, async
  - [ ] latch, barrier
  - [ ] mutex, semaphore
  - [ ] condition_variable
  - [ ] coroutines
- [ ] type traits
- [ ] ranges
- [ ] optional
- [ ] variant
- [ ] initialization
- [ ] string_view

# Algorithms
- [ ] Longest common subsequence

# DB
- `SELECT`
- joins ([Different Types of SQL JOINs](https://www.w3schools.com/sql/sql_join.asp)):
  - `(INNER) JOIN`: Returns records that have matching values in both tables
  - `LEFT (OUTER) JOIN`: Returns all records from the left table, and the matched records from the right table
  - `RIGHT (OUTER) JOIN`: Returns all records from the right table, and the matched records from the left table
  - `FULL (OUTER) JOIN`: Returns all records when there is a match in either left or right table

# See also
- [24 Essential C++ Interview Questions — Toptal](https://www.toptal.com/c-plus-plus/interview-questions)
- [Top 40 C++ Interview Questions and Answers in 2023 — hackr.io](https://hackr.io/blog/cpp-interview-questions)
- [C++ Interview Questions and Answers — knowledgehut](https://www.knowledgehut.com/interview-questions/c)
- [TOP 70 C++ Interview Questions and Answers [Includes Advanced]](https://www.softwaretestinghelp.com/cpp-interview-questions/)
- [The 10 most important C++ interview questions and answers for 2023 — Turing](https://www.turing.com/interview-questions/c++)
