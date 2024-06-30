---
title: Merge intervals
categories:
- interview
- problem
tags:
- LeetCode
- merge
- C++
---
# Problem

Given an array of `intervals` where `intervals[i] = [starti, endi]`, merge all overlapping intervals,
and return _an array of the non-overlapping intervals that cover all the intervals in the input_.

## Constraints

- `1 <= intervals.length <= 104`
- `intervals[i].length == 2`
- `0 <= starti <= endi <= 104`

## Example 1

- **Input**: `intervals = [[1,3],[2,6],[8,10],[15,18]]`
- **Output**: `[[1,6],[8,10],[15,18]]`
- **Explanation**: Since intervals `[1,3]` and `[2,6]` overlap, merge them into `[1,6]`.

## Example 2

- **Input**: `intervals = [[1,4],[4,5]]`
- **Output**: `[[1,5]]`
- **Explanation**: Intervals `[1,4]` and `[4,5]` are considered overlapping.

# Solution

```cpp
std::vector<std::vector<int>> merge(std::vector<std::vector<int>>& intervals) {
    const auto n = intervals.size();
    if (n < 2) return intervals;

    std::sort(intervals.begin(), intervals.end());  // O(N log N)

    std::vector<std::vector<int>> result{intervals.front()};
    for (auto i = 1; i < n; ++i) {  // O(N)
        const auto& interval = intervals[i];
        auto& last_end = result.back()[1];
        if (last_end >= interval[0]) {
            last_end = std::max(last_end, interval[1]);
        } else {
            result.push_back(interval);
        }
    }

    return result;
}
```

# Complexity

- Time: $O(n \log n)$.
- Space: $O(n)$.

# See Also

- [Merge Intervals](https://leetcode.com/problems/merge-intervals/ "Merge Intervals - LeetCode")
