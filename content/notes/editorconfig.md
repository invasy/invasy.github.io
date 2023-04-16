---
title: .editorconfig
categories:
- template
tags:
- editorconfig
- config
---
```ini {title=".editorconfig"}
root = true

[*]
charset = utf-8
indent_style = space
indent_size = 2

[*.yml]
indent_style = space
indent_size = 2

[*.sh]
end_of_line = lf

[{*.bat,*.cmd}]
end_of_line = crlf

[*.md]
indent_size = 4
```
