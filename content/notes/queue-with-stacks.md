---
title: Implement queue with two stacks
categories:
- problem
- interview
- data structure
tags:
- HackerRank
- LeetCode
- FIFO
- queue
- stack
- C++
- solution
---
# Queue using Two Stacks (HackerRank)

[Queue using Two Stacks](https://www.hackerrank.com/challenges/queue-using-two-stacks/problem "Queue using Two Stacks | HackerRank")

## Problem

A [queue] is an abstract data type that maintains the order in which elements were added to it,
allowing the oldest elements to be removed from the front and new elements to be added to the rear.
This is called a _First-In-First-Out_ ([FIFO]) data structure because the first element added to the queue
(i.&nbsp;e., the one that has been waiting the longest) is always the first one to be removed.

A basic queue has the following operations:
- _Enqueue_: add a new element to the end of the queue.
- _Dequeue_: remove the element from the front of the queue and return it.

In this challenge, you must first implement a queue using two stacks.
Then process $q$ queries, where each query is one of the following 3 types:
- `1 x`: Enqueue element `x` into the end of the queue.
- `2`: Dequeue the element at the front of the queue.
- `3`: Print the element at the front of the queue.

### Input Format

- The first line contains a single integer $q$, denoting the number of queries.
- Each line $i$ of the $q$ subsequent lines contains a single query in the form described in the problem statement above.
- All three queries start with an integer $type$ denoting the query type,
  but only query 1 is followed by an additional space-separated value $x$,
  denoting the value to be enqueued.

### Constraints

- $1 \leq q \leq 10^5$
- $1 \leq type \leq 3$
- $1 \leq |x| \leq 10^9$
- It is guaranteed that a valid answer always exists for each query of type 3.

### Output Format

For each query of type 3, print the value of the element at the front of the queue on a new line.

## Sample Test Case

### Input

```
STDIN   Function
-----   --------
10      q = 10 (number of queries)
1 42    1st query, enqueue 42
2       dequeue front element
1 14    enqueue 14
3       print the front element (14)
1 28    enqueue 28
3       print the front element (14)
1 60    enqueue 60
1 78    enqueue 78
2       dequeue front element
2       dequeue front element
```

### Output

```
14
14
```

### Explanation

Perform the following sequence of actions:
1. Enqueue $42$; $queue = \{42\}$.
2. Dequeue the value at the head of the queue, $42$; $queue = \{\}$.
3. Enqueue $14$; $queue = \{14\}$.
4. Print the value at the head of the queue, $14$; $queue = \{14\}$.
5. Enqueue $28$; $queue = \{14,~28\}$.
6. Print the value at the head of the queue, $14$; $queue = \{14,~28\}$.
7. Enqueue $60$; $queue = \{14,~28,~60\}$.
8. Enqueue $78; $queue = \{14,~28,~60,~78\}$.
9. Dequeue the value at the head of the queue, $14$; $queue = \{28,~60,~78\}$.
10. Dequeue the value at the head of the queue, $28$; $queue = \{60,~78\}$.

## Solution

```cpp
#include <iostream>
#include <stack>

namespace my {
    template<typename T>
    class queue {
        std::stack<T> a, b;
        T front_;

    public:
        queue() = default;

        void push(const T& x) {
            if (a.empty()) front_ = x;
            a.push(x);
        }

        T pop() {
            if (b.empty()) {
                while (!a.empty()) {
                    b.push(a.top()); a.pop();
                }
            }
            T x = b.top(); b.pop();
            return x;
        }

        T front() const {
            if (!b.empty()) return b.top();
            return front_;
        }
    };
}

using namespace std;

int main() {
    int n, t, x;
    my::queue<int> q;

    for (cin >> n; n; --n) {
        cin >> t;
        switch (t) {
            case 1: cin >> x; q.push(x); break;
            case 2: q.pop(); break;
            case 3: cout << q.front() << endl; break;
        }
    }

    return 0;
}
```

---

# Implement Queue using Stacks (LeetCode)

[Implement Queue using Stacks](https://leetcode.com/problems/implement-queue-using-stacks/ "Implement Queue using Stacks - LeetCode")

## Problem

Implement a first in first out ([FIFO]) [queue] using only two stacks.
The implemented queue should support all the functions of a normal queue
(`push`, `peek`, `pop`, and `empty`).

Implement the `MyQueue` class:
- `void push(int x)` Pushes element x to the back of the queue.
- `int pop()` Removes the element from the front of the queue and returns it.
- `int peek()` Returns the element at the front of the queue.
- `boolean empty()` Returns true if the queue is empty, false otherwise.

### Notes

You must use only standard operations of a stack, which means only the following operations are valid:
- push to top,
- peek/pop from top,
- size,
- is empty.

### Constraints

- `1 <= x <= 9`
- At most 100 calls will be made to `push`, `pop`, `peek`, and `empty`.
- All the calls to `pop` and `peek` are valid.

### Follow-up

Can you implement the queue such that each operation is amortized $O(1)$ time complexity?
In other words, performing $n$ operations will take overall $O(n)$ time even if one of those operations may take longer.

## Example

### Input

```
["MyQueue", "push", "push", "peek", "pop", "empty"]
[[], [1], [2], [], [], []]
```

### Output

```
[null, null, null, 1, 1, false]
```

### Explanation

```cpp
MyQueue myQueue = new MyQueue();
myQueue.push(1); // queue is: [1]
myQueue.push(2); // queue is: [1, 2] (leftmost is front of the queue)
myQueue.peek();  // return 1
myQueue.pop();   // return 1, queue is [2]
myQueue.empty(); // return false
```

## Solution

```cpp
class MyQueue {
    stack<int> a, b;
    int front{};

public:
    MyQueue() = default;
    
    void push(int x) {
        if (a.empty()) front = x;
        a.push(x);
    }
    
    int pop() {
        if (b.empty()) {
            while (!a.empty()) {
                b.push(a.top()); a.pop();
            }
        }
        int x = b.top(); b.pop();
        return x;
    }
    
    int peek() const {
        if (!b.empty()) return b.top();
        return front;
    }
    
    bool empty() const {
        return a.empty() && b.empty();
    }
};
```

[queue]: https://en.wikipedia.org/wiki/Queue_%28abstract_data_type%29 "Queue — Wikipedia"
[FIFO]: https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics) "FIFO — Wikipedia"
