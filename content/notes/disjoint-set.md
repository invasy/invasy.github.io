---
title: Disjoint-set
categories:
- data structure
tags:
- disjoint-set
- union-find
- merge-find
- tree
- graph
---
# C++
```cpp
#include <algorithm>
#include <numeric>
#include <vector>

class UnionFind {
    std::vector<std::size_t> root, rank;
    std::size_t components_;

public:
    UnionFind(std::size_t size) : root(size), rank(size), components_{size} {
        std::iota(root.begin(), root.end(), 0);
    }

    std::size_t find(std::size_t x) {
        while (x != root[x])
            x = root[x] = root[root[x]];
        return x;
    }

    void merge(std::size_t x, std::size_t y) {
        auto rx = find(x), ry = find(y);
        if (rx == ry) return;

        if (rank[rx] > rank[ry]) {
            std::swap(rx, ry);
        } else if (rank[rx] == rank[ry]) {
            ++rank[ry];
        }

        root[rx] = ry;
        --components_;
    }

    std::size_t components() const {
        return components_;
    }
};
```

# See also
- [Disjoint-set data structure](https://en.wikipedia.org/wiki/Disjoint-set_data_structure "Disjoint-set data structure — Wikipedia")
