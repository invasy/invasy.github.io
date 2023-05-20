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
  - [ ] `std::array` — static array
  - [ ] `std::vector` — dynamic array
  - [ ] `std::deque`
  - [ ] `std::map` — self-balnced tree — red-black tree (RBT)
  - [ ] `std::unordered_map` — hash table
  - [ ] `std::set`
  - [ ] `std::unordered_set`
  - [ ] `std::stack`
  - [ ] `std::queue`
  - [ ] `std::priority_queue`
  - [ ] `std::list` — doubly-linked list
  - [ ] spans
- [ ] Exceptions:
  - [ ] `throw`
  - [ ] `try`, `catch`, `finally`
  - [ ] stack unwinding
  - [ ] keyword `noexcept`
  - [ ] can constructor raise exceptions?
  - [ ] can destructor raise exceptions?
  - [ ] catching by reference
- [ ] keyword `volatile`
- [ ] inheritance
- [ ] keyword `virtual`:
  - [ ] virtual functions
  - [ ] virtual destructor
  - [ ] pure virtual functions
  - [ ] abstract classes
  - [ ] interfaces
  - [ ] keyword `override`
  - [ ] vptr
  - [ ] vtable
  - [ ] can constructor be virtual?
  - [ ] calling virtual methods from a constructor
    - Yes, we can call a virtual function from a constructor. But it can throw an exception of overriding.
  - [ ] calling virtual methods from a destructor
- [ ] `struct` vs `class`
- [ ] `lvalue`, `rvalue`
- [ ] move semantics
- [ ] perfect forwarding
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
- [ ] keyword `inline`
- [ ] keyword `static`
- [ ] storage class
- [ ] keyword `mutable`
- [ ] keyword `auto`
- [ ] namespaces
  - [ ] anonymous namespace
- [ ] anatomy of a class, memory layout
- [ ] size of an empty class
- [ ] `this` pointer
- [ ] lambdas
- [ ] function overloading
- [ ] concurrency:
  - [ ] `std::mutex`, `std::lock_guard`
  - [ ] `std::semaphore`
  - [ ] condition_variable
  - [ ] `std::thread` and `std::jthread`
  - [ ] future, promise, async
  - [ ] latch, barrier
  - [ ] coroutines
- [ ] type traits
- [ ] ranges
- [ ] `std::optional`
- [ ] `std::variant`
- [ ] initialization
- [ ] `std::string_view`

# Algorithms
- [ ] Longest common subsequence

# DB
- `SELECT`
- joins ([Different Types of SQL JOINs](https://www.w3schools.com/sql/sql_join.asp)):
  - `(INNER) JOIN`: Returns records that have matching values in both tables
  - `LEFT (OUTER) JOIN`: Returns all records from the left table, and the matched records from the right table
  - `RIGHT (OUTER) JOIN`: Returns all records from the right table, and the matched records from the left table
  - `FULL (OUTER) JOIN`: Returns all records when there is a match in either left or right table

# System design
- [25 Software Design Interview Questions to Crack Any Programming and Technical Interviews](https://medium.com/javarevisited/25-software-design-interview-questions-to-crack-any-programming-and-technical-interviews-4b8237942db0 "25 Software Design Interview Questions to Crack Any Programming and Technical Interviews")
- [Top 10 System Design Interview Questions and Answers](https://www.geeksforgeeks.org/top-10-system-design-interview-questions-and-answers/ "Top 10 System Design Interview Questions and Answers")
- 

# See also
- [24 Essential C++ Interview Questions — Toptal](https://www.toptal.com/c-plus-plus/interview-questions)
- [Top 40 C++ Interview Questions and Answers in 2023 — hackr.io](https://hackr.io/blog/cpp-interview-questions)
- [C++ Interview Questions and Answers — knowledgehut](https://www.knowledgehut.com/interview-questions/c)
- [TOP 70 C++ Interview Questions and Answers [Includes Advanced]](https://www.softwaretestinghelp.com/cpp-interview-questions/)
- [The 10 most important C++ interview questions and answers for 2023 — Turing](https://www.turing.com/interview-questions/c++)
