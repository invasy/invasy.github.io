---
title: Virtual Destructor (C++)
categories:
- interview
tags:
- C++
- destructor
- virtual destructor
- UB
---
Deleting a derived class object using a pointer of base class type that has a non-virtual destructor results in ***undefined behavior***.

## Non-virtual Destructor

### Code

```cpp
#include <iostream>

using namespace std;

struct A {
    A() { cout << __PRETTY_FUNCTION__ << endl; }
    ~A() { cout << __PRETTY_FUNCTION__ << endl; }
};

struct B : public A {
    B() { cout << __PRETTY_FUNCTION__ << endl; }
    ~B() { cout << __PRETTY_FUNCTION__ << endl; }
};

int main() {
    A *a = new B();

    delete a;

    return 0;
}

```

### Result

```
A::A()
B::B()
A::~A()
```

## Virtual Destructor

### Code

```cpp
#include <iostream>

using namespace std;

struct A {
    A() { cout << __PRETTY_FUNCTION__ << endl; }
    virtual ~A() { cout << __PRETTY_FUNCTION__ << endl; }
};

struct B : public A {
    B() { cout << __PRETTY_FUNCTION__ << endl; }
    virtual ~B() { cout << __PRETTY_FUNCTION__ << endl; }
};

int main() {
    A *a = new B();

    delete a;

    return 0;
}

```

### Result

```
A::A()
B::B()
virtual B::~B()
virtual A::~A()
```

# See Also

- [Destructors — cppreference.com](https://en.cppreference.com/w/cpp/language/destructor "Destructors — cppreference.com")
- [Virtual Destructor — GeeksforGeeks](https://www.geeksforgeeks.org/virtual-destructor/ "Virtual Destructor — GeeksforGeeks")
