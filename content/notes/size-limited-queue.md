---
title: Size-limited queue
categories:
- data structure
- interview
- problem
tags:
- C++
- queue
---
## Problem

Implement size-limited queue.

### Requirements

- Interface:
  - `push` — add an element to the queue.
  - `pop` — remove an elemtn from the queue and return it.
- Complexity:
  - Time:
    - `push`: \\(O(1)\\) (_amortized_).
    - `pop`: \\(O(1)\\) (_amortized_).
  - Space: \\(O(n)\\).
- Do not use standard containers except `std::vector`.

## Solution 1

Two stacks:
```cpp {title="limited_queue.h"}
#include <optional>
#include <vector>

template<typename T>
class limited_queue {
    std::size_t max_size;
    std::vector<T> a, b;

    void move(std::size_t n = 0) {
        while (a.size() > n) {
            b.push(a.back());
            a.pop_back();
        }
        a.clear();
    }

public:
    limited_queue() = delete;
    limited_queue(std::size_t size) : max_size{size} {}

    void push(const T& value) {
        a.push(value);
        if (a.size() >= max_size) move(1);
        if (a.size() + b.size() >= max_size) b.pop_back();
    }

    std::optional<T> pop() {
        if (a.empty() && b.empty()) return std::nullopt;
        if (b.empty()) move();

        T t = b.back();
        b.pop_back();

        return t;
    }
};
```

## Solution 2

Deque:
```cpp {title="limited_queue.h"}
#include <deque>
#include <optional>

template<typename T>
class limited_queue {
    std::size_t max_size;
    std::deque<T> data;

public:
    limited_queue() = delete;
    limited_queue(std::size_t size) : max_size{size} {}

    void push(const T& value) {
        data.push_back(value);
        if (data.size() >= max_size)
            data.pop_front();
    }

    std::optional<T> pop() {
        if (data.empty()) return std::nullopt;
        T t = data.front(); data.pop_front();
        return t;
    }
};
```
