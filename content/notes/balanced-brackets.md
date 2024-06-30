---
title: Balanced Brackets or Valid Parentheses
categories:
- problem
tags:
- HackerRank
- LeetCode
- solution
- stack
draft: true
---
# Balanced Brackets (HackerRank)

[Balanced Brackets](https://www.hackerrank.com/challenges/balanced-brackets/problem "Balanced Brackets | HackerRank")

## Solution

```cpp {hl_lines=["8-20"]}
#include <bits/stdc++.h>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);

string isBalanced(const string& s) {
    stack<char> b;

    for (const auto& c : s) {
        if (c == ')' || c == '}' || c == ']') {
            if (b.empty() || b.top() != c - 1 - (c != ')'))
                return "NO";
            b.pop();
        } else b.push(c);
    }

    return b.empty() ? "YES" : "NO";
}

int main() {
    ofstream fout(getenv("OUTPUT_PATH"));

    string t_temp;
    getline(cin, t_temp);

    int t = stoi(ltrim(rtrim(t_temp)));

    for (int t_itr = 0; t_itr < t; t_itr++) {
        string s;
        getline(cin, s);

        string result = isBalanced(s);

        fout << result << "\n";
    }

    fout.close();

    return 0;
}

string ltrim(const string &str) {
    string s(str);

    s.erase(
        s.begin(),
        find_if(s.begin(), s.end(), not1(ptr_fun<int, int>(isspace)))
    );

    return s;
}

string rtrim(const string &str) {
    string s(str);

    s.erase(
        find_if(s.rbegin(), s.rend(), not1(ptr_fun<int, int>(isspace))).base(),
        s.end()
    );

    return s;
}
```

# Valid Parentheses (LeetCode)

[Valid Parentheses](https://leetcode.com/problems/valid-parentheses/ "Valid Parentheses - LeetCode")

## Solution

```cpp
class Solution {
public:
    bool isValid(const string& s) {
        stack<char> b;

        for (const auto& c : s) {
            if (c == ')' || c == '}' || c == ']') {
                if (b.empty() || b.top() != c - 1 - (c != ')'))
                    return false;
                b.pop();
            } else b.push(c);
        }

        return b.empty();
    }
};
```
