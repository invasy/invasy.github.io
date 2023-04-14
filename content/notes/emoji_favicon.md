---
title: Emoji favicon
tags:
- favicon
- emoji
- HTML
- JavaScript
---
```html {title="index.html"}
<link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>✌🏻</text></svg>">
```

```js {title="favicon.js"}
const favicon = document.querySelector('head > link[rel="icon"]');

function faviconData(string, emoji) {
  return `data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>${emoji}</text></svg>`.trim();
}

function setFavicon(emoji) {
    favicon.setAttribute('href', faviconData`${emoji}`)
}
```

## See Also
- [How To Use an Emoji as a Favicon Easily](https://css-tricks.com/emoji-as-a-favicon/)
- [Favicon Machine](https://codepen.io/chriscoyier/project/editor/ZeWQWJ)
- [Lea Verou Original Tweet](https://twitter.com/LeaVerou/status/1241619866475474946)
