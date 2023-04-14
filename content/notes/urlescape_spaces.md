---
title: Replace spaces with `%20`
categories:
- interview
tags:
- C++
- string
---
## Task
Replace all space characters in a string with `%20`
([percent-encoding](https://en.wikipedia.org/wiki/URL_encoding "URL encoding — Wikipedia")).

## Solution
```cpp {title="encode_spaces.cpp"}
#include <algorithm>
#include <string>

void url_encode(std::string& s) {
    const auto size = s.size();

    const auto spaces = std::count_if(s.begin(), s.end(), [](const auto& c) { return c == ' '; });
    /* or using for loop:
    size_t spaces{};
    for (size_t i = 0; i < size; ++i)
        if (s[i] == ' ')
            ++spaces;
    //*/

    const auto new_size = size + 2 * spaces;
    s.resize(new_size);
    for (int i = size - 1, j = new_size - 1; ~i; --i, --j) {  // `~i` is the same as `i >= 0`
        if (s[i] == ' ') {
            s[j--] = '0';
            s[j--] = '2';
            s[j] = '%';
        } else s[j] = s[i];
    }
}
```
