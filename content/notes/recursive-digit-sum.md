---
title: Recursive digit sum
categories:
- problem
tags:
- HackerRank
- LeetCode
- solution
---
# Problem
Given an integer number $n$ calculate sum of its digits recursively:
repeatedly add all its digits until the result has only one digit.

## Complexity
- **Time**: $O(1)$
- **Space**: $O(1)$

# Recursive Digit Sum (HackerRank)
[Recursive Digit Sum | HackerRank](https://www.hackerrank.com/challenges/one-week-preparation-kit-recursive-digit-sum/problem "Recursive Digit Sum | HackerRank")

## Solution
```cpp
#include <bits/stdc++.h>

using namespace std;

int main() {
    string n;
    int k;
    long p{};

    cin >> n >> k;

    for (const auto& c : n)
        p += c - '0';
    p *= k;

    cout << (1 + (p - 1) % 9) << endl;

    return 0;
}
```

# Add Digits (LeetCode)
[Add Digits - LeetCode](https://leetcode.com/problems/add-digits/ "Add Digits - LeetCode")

## Solution
```cpp
class Solution {
public:
    int addDigits(int num) {
        return 1 + (num - 1) % 9;
    }
};
```
