---
title: Constructors and exceptions
categories:
- intervew
tags:
- C++
- default initialization
- copy initialization
- constructor
- default constructor
- copy constructor
- destructor
- virtual destructor
- exceptions
- throw
- try
- catch
---
# Task
What will the following code print to `stdout`?

```cpp
#include <iostream>

using namespace std;

struct A {
    A() { cout << __PRETTY_FUNCTION__ << endl; }
    virtual ~A() { cout << __PRETTY_FUNCTION__ << endl; }
};

struct C {
    C() { cout << __PRETTY_FUNCTION__ << endl; }
    ~C() { cout << __PRETTY_FUNCTION__ << endl; }
};

struct D {
    D() { cout << __PRETTY_FUNCTION__ << endl; }
    ~D() { cout << __PRETTY_FUNCTION__ << endl; }
};

struct E {
    E() { cout << __PRETTY_FUNCTION__ << endl; }
    E(const E&) { cout << __PRETTY_FUNCTION__ << endl; }
    ~E() { cout << __PRETTY_FUNCTION__ << endl; }
};

struct B: A {
    D d;

    B() {
        try {
            C c;
            throw E();
        } catch (E e) {
            cout << "catch" << endl;
        }
        throw E();
    }

    ~B() { cout << __PRETTY_FUNCTION__ << endl; }
};

int main() {
    try {
        B b;
    } catch (const E&) {
    }

    return 0;
}
```

# Solution
```text
A::A()
D::D()
C::C()
E::E()
C::~C()
E::E(const E&)
catch
E::~E()
E::~E()
E::E()
D::~D()
virtual A::~A()
E::~E()
```

# Explanation
1. [`try`][try] block in `main()`.
2. [Default initialization][default_init] of local variable `b` in `main()`.
3. [Default constructor][default_ctor] of a [base class][derived] `A::A()`.
4. [Default initialization][default_init] of data member `B::d`.
5. [Default constructor][default_ctor] `D::D()`.
6. [Default constructor][default_ctor] `B::B()`.
7. [Default initialization][default_init] of local variable `c` in `B::B()`.
8. [Default constructor][default_ctor] `C::C()`.
9. [Throw] exception object `E` (temporary object with unspecified duration).
10. [Default constructor][default_ctor] `E::E()`.
11. [Stack unwinding][unwinding].
12. [Destructor][dtor] `C::~C()` (object with [automatic storage duration][duration]) at the end of `try` block.
13. `catch` exception object `E` by value.
14. [Copy initialization][copy_init] of exception object: [copy constructor][copy_ctor] `E::E(const E&)`.
15. Print `catch`.
16. [Destructor][dtor] `E::~E()` (exception object from step 14) at the end of `try-catch` clause.
17. [Destructor][dtor] `E::~E()` (exception object from step 10) at the end of `try-catch` clause.
18. [Throw] exception object `E` (temporary object with unspecified duration).
19. [Default constructor][default_ctor] `E::E()`.
20. `catch` exception object `E` by constant reference in `main()`.
21. End of `try-catch` clause in `main()`.
22. [Destructor][dtor] `D::~D()` of data member `B::d` initialized in step 4.
23. [Virtual destructor][virtual_dtor] `A::~A()` of base class `A` initialized in step 3.
24. [Destructor][dtor] `E::~E()` (exception object from step 19) at the end of `main()`.

[try]: https://en.cppreference.com/w/cpp/language/try_catch "try-block — cppreference.com"
[default_init]: https://en.cppreference.com/w/cpp/language/default_initialization "Default initialization — cppreference.com"
[copy_init]: https://en.cppreference.com/w/cpp/language/copy_initialization "Copy initialization — cppreference.com"
[default_ctor]: https://en.cppreference.com/w/cpp/language/default_constructor "Default constructor — cppreference.com"
[copy_ctor]: https://en.cppreference.com/w/cpp/language/copy_constructor "Copy constructor — cppreference.com"
[dtor]: https://en.cppreference.com/w/cpp/language/destructor "Destructor — cppreference.com"
[virtual_dtor]: https://en.cppreference.com/w/cpp/language/destructor#Virtual_destructors "Virtual destructor — cppreference.com"
[derived]: https://en.cppreference.com/w/cpp/language/derived_class "Derived class — cppreference.com"
[throw]: https://en.cppreference.com/w/cpp/language/throw "throw expression — cppreference.com"
[duration]: https://en.cppreference.com/w/cpp/language/storage_duration "Storage class specifiers — cppreference.com"
[unwinding]: https://en.cppreference.com/w/cpp/language/throw#Stack_unwinding "Stack unwinding — cppreference.com"
