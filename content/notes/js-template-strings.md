---
title: JavaScript Template Strings
categories:
- reference
tags:
- JavaScript
- template
---
# Template literals

```js
`text${expression}text`
```

# Tagged templates

```js
function tagFunction(strings, arg) {
    return `${strings[0]}${arg}${strings[1]}`
}

tagFunction`text${expression}text`
```

# See Also

- [Template literals (Template strings) | MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals "Template literals (Template strings) | MDN")