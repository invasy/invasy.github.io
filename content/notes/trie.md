---
title: Trie
categories:
- data structure
tags:
- trie
- prefix tree
draft: true
---
# Trie
- [Trie](https://en.wikipedia.org/wiki/Trie "Trie — Wikipedia"), digital tree, prefix tree

# No Prefix Set (HackerRank)
[No Prefix Set](https://www.hackerrank.com/challenges/no-prefix-set/problem "No Prefix Set | HackerRank")

## Solution
```cpp
#include <bits/stdc++.h>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);

template<char first_char, size_t alphabet_size>
class Trie {
    struct Node {
        bool end{};
        array<Node*, alphabet_size> next{};
        ~Node() { for (const auto& n : next) if (n) delete n; }
    };

    Node* root;

public:
    Trie() : root{new Node()} {}
    ~Trie() { delete root; }

    void insert(const string& word) {
        auto node = root;
        for (const auto& c : word) {
            auto& next = node->next[c-first_char];
            if (!next) next = new Node();
            node = next;
        }
        node->end = true;
    }

    bool hasPrefix(const string& prefix) const {
        const auto n = prefix.size();
        auto node = root;
        for (auto i = 0; i < n && node && !node->end; ++i)
            node = node->next[prefix[i]-first_char];
        return bool(node);
    }
};

void noPrefix(const vector<string>& words) {
    const auto n = words.size();

    Trie<'a', 'j'-'a'+1> t;

    t.insert(words[0]);
    for (size_t i = 1; i < n; ++i) {
        const auto& w = words[i];
        if (t.hasPrefix(w)) {
            cout << "BAD SET\n" << w << endl;
            return;
        }
        t.insert(w);
    }
    cout << "GOOD SET" << endl;
}

int main()
{
    string n_temp;
    getline(cin, n_temp);

    int n = stoi(ltrim(rtrim(n_temp)));

    vector<string> words(n);

    for (int i = 0; i < n; i++) {
        string words_item;
        getline(cin, words_item);

        words[i] = words_item;
    }

    noPrefix(words);

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

# Implement Trie (Prefix Tree) (LeetCode)
[Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree/ "Implement Trie (Prefix Tree) - LeetCode")

## Solution
```cpp
class Trie {
    struct Node {
        bool end{};
        array<Node*, 26> next{};
        ~Node() { for (const auto& n : next) if (n) delete n; }
    };

    Node* root;

    Node* find_(const string& key) const {
        const auto n = key.size();
        auto node = root;
        for (auto i = 0; i < n && node; ++i)
            node = node->next[key[i]-'a'];
        return node;
    }

public:
    Trie() : root{new Node()} {}
    ~Trie() { delete root; }
    
    void insert(const string& word) {
        auto node = root;
        for (const auto& c : word) {
            auto& next = node->next[c-'a'];
            if (!next) next = new Node();
            node = next;
        }
        node->end = true;
    }
    
    bool search(const string& word) const {
        auto node = find_(word);
        return node && node->end;
    }
    
    bool startsWith(const string& prefix) const {
        return bool(find_(prefix));
    }
};
```
