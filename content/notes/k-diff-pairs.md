---
title: K-diff Pairs in an Array
categories:
- problem
tags:
- HackerRank
- LeetCode
- solution
- map
draft: true
---
# Pairs (HackerRank)
[Pairs](https://www.hackerrank.com/challenges/pairs/problem "Pairs | HackerRank")

## Solution
```cpp {hl_lines=["9-19"]}
#include <bits/stdc++.h>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);
vector<string> split(const string &);

int pairs(int k, const vector<int>& arr) {
    unordered_map<int, int> m;
    for (const auto& x : arr) ++m[x];

    int result{};
    for (const auto& [x, c] : m)
        if ((!k && c > 1) || (k && m.count(x + k)))
            ++result;

    return result;
}

int main() {
    ofstream fout(getenv("OUTPUT_PATH"));

    string first_multiple_input_temp;
    getline(cin, first_multiple_input_temp);

    vector<string> first_multiple_input = split(rtrim(first_multiple_input_temp));

    int n = stoi(first_multiple_input[0]);

    int k = stoi(first_multiple_input[1]);

    string arr_temp_temp;
    getline(cin, arr_temp_temp);

    vector<string> arr_temp = split(rtrim(arr_temp_temp));

    vector<int> arr(n);

    for (int i = 0; i < n; i++) {
        int arr_item = stoi(arr_temp[i]);

        arr[i] = arr_item;
    }

    int result = pairs(k, arr);

    fout << result << "\n";

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

vector<string> split(const string &str) {
    vector<string> tokens;

    string::size_type start = 0;
    string::size_type end = 0;

    while ((end = str.find(" ", start)) != string::npos) {
        tokens.push_back(str.substr(start, end - start));

        start = end + 1;
    }

    tokens.push_back(str.substr(start));

    return tokens;
}
```

# K-diff Pairs in an Array (LeetCode)
[K-diff Pairs in an Array](https://leetcode.com/problems/k-diff-pairs-in-an-array/ "K-diff Pairs in an Array - LeetCode")

## Solution
```cpp
class Solution {
public:
    int findPairs(vector<int>& nums, int k) {
        unordered_map<int, int> m;
        for (const auto& n : nums) ++m[n];

        int result{};
        for (const auto& [n, c] : m)
            if ((!k && c > 1) || (k && m.count(n + k)))
                ++result;

        return result;
    }
};
```
