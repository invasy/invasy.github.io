---
title: Truck Tour or Gas Station
categories:
- interview
- problem
tags:
- HackerRank
- LeetCode
- problem
- solution
- array
- greedy algorithm
---
# Truck Tour (HackerRank)
[Truck Tour | HackerRank](https://www.hackerrank.com/challenges/truck-tour/problem "Truck Tour | HackerRank")

## Problem
Suppose there is a circle. There are $N$ petrol pumps on that circle.
Petrol pumps are numbered $0$ to $N-1$ (both inclusive).

You have two pieces of information corresponding to each of the petrol pump:
1) the amount of petrol that particular petrol pump will give,
2) the distance from that petrol pump to the next petrol pump.

Initially, you have a tank of infinite capacity carrying no petrol.
You can start the tour at any of the petrol pumps.

Calculate the first point from where the truck will be able to complete the circle.
Consider that the truck will stop at each of the petrol pumps.
The truck will move one kilometer for each litre of the petrol.

### Input Format
The first line will contain the value of $N$.

The next $N$ lines will contain a pair of integers each:
- the amount of petrol that petrol pump will give;
- the distance between that petrol pump and the next petrol pump.

### Constraints
- $1 \leq N \leq 10^5$
- $1 \leq \text{amount of petrol},~\text{distance} \leq 10^9$

### Output Format
An integer which will be the smallest index of the petrol pump from which we can start the tour.

## Sample test case
### Input
```
3
1 5
10 3
3 4
```
### Output
```
1
```
### Explanation
We can start the tour from the second petrol pump.

## Solution
```cpp
#include <bits/stdc++.h>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);
vector<string> split(const string &);

int truckTour(const vector<vector<int>>& petrolpumps) {
    const auto n = petrolpumps.size();

    int tank{}, start{};

    for (size_t i = 0; i < n; ++i) {
        const auto& pump = petrolpumps[i];
        tank += pump[0] - pump[1];
        if (tank < 0)
            tank = 0, start = i + 1;
    }

    return start;
}

int main() {
    ofstream fout(getenv("OUTPUT_PATH"));

    string n_temp;
    getline(cin, n_temp);

    int n = stoi(ltrim(rtrim(n_temp)));

    vector<vector<int>> petrolpumps(n);

    for (int i = 0; i < n; i++) {
        petrolpumps[i].resize(2);

        string petrolpumps_row_temp_temp;
        getline(cin, petrolpumps_row_temp_temp);

        vector<string> petrolpumps_row_temp = split(rtrim(petrolpumps_row_temp_temp));

        for (int j = 0; j < 2; j++) {
            int petrolpumps_row_item = stoi(petrolpumps_row_temp[j]);

            petrolpumps[i][j] = petrolpumps_row_item;
        }
    }

    int result = truckTour(petrolpumps);

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

# Gas Station (LeetCode)
[Gas Station - LeetCode](https://leetcode.com/problems/gas-station/ "Gas Station - LeetCode")

## Problem
There are `n` gas stations along a circular route, where the amount of gas at the $i^{th}$ station is `gas[i]`.

You have a car with an unlimited gas tank and it costs `cost[i]` of gas to travel from the $i^{th}$ station
to its next `(i + 1)th` station. You begin the journey with an empty tank at one of the gas stations.

Given two integer arrays `gas` and `cost`, return the starting gas station's index
if you can travel around the circuit once in the clockwise direction, otherwise return `-1`.
If there exists a solution, it is **guaranteed** to be **unique**.

## Example 1
### Input
```
gas = [1,2,3,4,5], cost = [3,4,5,1,2]
```
### Output
```
3
```
### Explanation
1. Start at station 3 (index 3) and fill up with 4 unit of gas. Your $\text{tank} = 0 + 4 = 4$.
2. Travel to station 4. Your $\text{tank} = 4 - 1 + 5 = 8$.
3. Travel to station 0. Your $\text{tank} = 8 - 2 + 1 = 7$.
4. Travel to station 1. Your $\text{tank} = 7 - 3 + 2 = 6$.
5. Travel to station 2. Your $\text{tank} = 6 - 4 + 3 = 5$.
6. Travel to station 3. The cost is 5. Your gas is just enough to travel back to station 3.
7. Therefore, return 3 as the starting index.

## Example 2
### Input
```
gas = [2,3,4], cost = [3,4,3]
```
### Output
```
-1
```
### Explanation
1. You can't start at station 0 or 1, as there is not enough gas to travel to the next station.
2. Let's start at station 2 and fill up with 4 unit of gas. Your $\text{tank} = 0 + 4 = 4$.
3. Travel to station 0. Your $\text{tank} = 4 - 3 + 2 = 3$.
4. Travel to station 1. Your $\text{tank} = 3 - 3 + 3 = 3$.
5. You cannot travel back to station 2, as it requires 4 unit of gas but you only have 3.
6. Therefore, you can't travel around the circuit once no matter where you start.

## Solution
```cpp
class Solution {
public:
    int canCompleteCircuit(const vector<int>& gas, const vector<int>& cost) {
        const auto n = gas.size();

        int tank{}, total{}, start{};

        for (auto i = 0; i < n; ++i) {
            int g = gas[i] - cost[i];
            tank += g, total += g;
            if (tank < 0) tank = 0, start = i + 1;
        }

        return total >= 0 ? start : -1;
    }
};
```

# Method
[Greedy algorithm](https://en.wikipedia.org/wiki/Greedy_algorithm "Greedy algorithm — Wikipedia").
