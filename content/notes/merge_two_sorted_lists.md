---
title: Merge two sorted lists
categories:
- interview
- problem
tags:
- HackerRank
- LeetCode
- linked list
- merge
- solution
- C++
---
# Merge two sorted linked lists (HackerRank)
[Merge two sorted linked lists](https://www.hackerrank.com/challenges/merge-two-sorted-linked-lists/problem "Merge two sorted linked lists | HackerRank")

## Problem
Given pointers to the heads of two sorted linked lists, merge them into a single, sorted linked list.
Either head pointer may be null meaning that the corresponding list is empty.

### Example
- $headA$ refers to $1 \rightarrow 3 \rightarrow 7 \rightarrow \text{NULL}$
- $headB$ refers to $1 \rightarrow 2 \rightarrow \text{NULL}$
- The new list is $1 \rightarrow 1 \rightarrow 2 \rightarrow 3 \rightarrow 7 \rightarrow \text{NULL}$

### Function Description
`mergeLists` function has the following parameters:
- `SinglyLinkedListNode` pointer `headA`: a reference to the head of the first list;
- `SinglyLinkedListNode` pointer `headB`: a reference to the head of the second list.

### Returns
- `SinglyLinkedListNode` pointer: a reference to the head of the merged list.

### Input Format
The first line contains an integer $t$, the number of test cases.

The format for each test case is as follows:
- The first line contains an integer $n$, the length of the first linked list.
- The next $n$ lines contain an integer each, the elements of the first linked list.
- The next line contains an integer $m$, the length of the second linked list.
- The next $m$ lines contain an integer each, the elements of the second linked list.

### Constraints
- $1 \leq t \leq 10$
- $1 \leq n,~m \leq 1000$
- $1 \leq list[i] \leq 1000$, where $list[i]$ is the $i^{th}$ element of the list

## Sample Test Case
### Input
```
1
3
1
2
3
2
3
4
```
### Output
```
1 2 3 3 4
```
### Explanation
- The first linked list is: $1 \rightarrow 2 \rightarrow 3 \rightarrow \text{NULL}$
- The second linked list is: $3 \rightarrow 4 \rightarrow \text{NULL}$
- Hence, the merged linked list is:  $1 \rightarrow 2 \rightarrow 3 \rightarrow 3 \rightarrow 4 \rightarrow \text{NULL}$

## Solution
```cpp {hl_lines=["60-77"]}
#include <bits/stdc++.h>

using namespace std;

class SinglyLinkedListNode {
    public:
        int data;
        SinglyLinkedListNode *next;

        SinglyLinkedListNode(int node_data) {
            this->data = node_data;
            this->next = nullptr;
        }
};

class SinglyLinkedList {
    public:
        SinglyLinkedListNode *head;
        SinglyLinkedListNode *tail;

        SinglyLinkedList() {
            this->head = nullptr;
            this->tail = nullptr;
        }

        void insert_node(int node_data) {
            SinglyLinkedListNode* node = new SinglyLinkedListNode(node_data);

            if (!this->head) {
                this->head = node;
            } else {
                this->tail->next = node;
            }

            this->tail = node;
        }
};

void print_singly_linked_list(SinglyLinkedListNode* node, string sep, ofstream& fout) {
    while (node) {
        fout << node->data;

        node = node->next;

        if (node) {
            fout << sep;
        }
    }
}

void free_singly_linked_list(SinglyLinkedListNode* node) {
    while (node) {
        SinglyLinkedListNode* temp = node;
        node = node->next;

        free(temp);
    }
}

SinglyLinkedListNode* mergeLists(SinglyLinkedListNode* head1, SinglyLinkedListNode* head2) {
    if (!head1) return head2;
    if (!head2) return head1;

    auto *i = head1, *j = head2;
    if (i->data > j->data) swap(i, j);
    auto *merged = i;

    while (i->next && j) {
        if (i->next->data > j->data) {
            swap(i->next, j->next);
            swap(i->next, j);
        } else i = i->next;
    }
    if (j) i->next = j;

    return merged;
}

int main() {
    ofstream fout(getenv("OUTPUT_PATH"));

    int tests;
    cin >> tests;
    cin.ignore(numeric_limits<streamsize>::max(), '\n');

    for (int tests_itr = 0; tests_itr < tests; tests_itr++) {
        SinglyLinkedList* llist1 = new SinglyLinkedList();

        int llist1_count;
        cin >> llist1_count;
        cin.ignore(numeric_limits<streamsize>::max(), '\n');

        for (int i = 0; i < llist1_count; i++) {
            int llist1_item;
            cin >> llist1_item;
            cin.ignore(numeric_limits<streamsize>::max(), '\n');

            llist1->insert_node(llist1_item);
        }
      
      	SinglyLinkedList* llist2 = new SinglyLinkedList();

        int llist2_count;
        cin >> llist2_count;
        cin.ignore(numeric_limits<streamsize>::max(), '\n');

        for (int i = 0; i < llist2_count; i++) {
            int llist2_item;
            cin >> llist2_item;
            cin.ignore(numeric_limits<streamsize>::max(), '\n');

            llist2->insert_node(llist2_item);
        }

        SinglyLinkedListNode* llist3 = mergeLists(llist1->head, llist2->head);

        print_singly_linked_list(llist3, " ", fout);
        fout << "\n";

        free_singly_linked_list(llist3);
    }

    fout.close();

    return 0;
}
```

---

# Merge Two Sorted Lists (LeetCode)
[Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/ "Merge Two Sorted Lists - LeetCode")

## Problem
You are given the heads of two sorted linked lists `list1` and `list2`.

Merge the two lists in a one **sorted** list. The list should be made by splicing together the nodes of the first two lists.

_Return the head of the merged linked list._

### Constraints
- The number of nodes in both lists is in the range `[0, 50]`.
- `-100 <= Node.val <= 100`.
- Both `list1` and `list2` are sorted in non-decreasing order.

## Example 1
### Input
```
list1 = [1,2,4], list2 = [1,3,4]
```
### Output
```
[1,1,2,3,4,4]
```

## Example 2
### Input
```
list1 = [], list2 = []
```
### Output
```
[]
```

## Example 3
### Input
```
list1 = [], list2 = [0]
```
### Output
```
[0]
```

## Solution
```cpp
class Solution {
public:
    ListNode* mergeTwoLists(ListNode* list1, ListNode* list2) {
        // Trivial cases with at least one empty list
        if (!list1) return list2;
        if (!list2) return list1;

        ListNode *i = list1, *j = list2;
        if (i->val > j->val) swap(i, j);
        // `i` points to the list with a lesser first element (at index 0)
        ListNode *merged = i;  // Head of the merged list

        // Traverse lists until the shorter list ends
        while (i->next && j) {
            if (i->next->val > j->val) {
                swap(i->next, j->next);
                swap(i->next, j);
            } else i = i->next;
        }
        // Append elements from the longer list (if any)
        if (j) i->next = j;

        return merged;
    }
};
```
