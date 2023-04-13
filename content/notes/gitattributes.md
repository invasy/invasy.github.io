---
title: .gitattributes
tags:
- Git
- gitattributes
- template
---
# .gitattributes
```
*  text=auto
```

## C / C++
```
*.c     text diff=c
*.cc    text diff=cpp
*.cxx   text diff=cpp
*.cpp   text diff=cpp
*.c++   text diff=cpp
*.hpp   text diff=cpp
*.h     text diff=c
*.h++   text diff=cpp
*.hh    text diff=cpp
```

## Java
```
*.java        text diff=java
*.gradle      text diff=java
*.gradle.kts  text diff=java
```

## Go
```
*.go  text eol=lf diff=golang
```

## Haskell
```
*.hs  text
```

## Python
```
*.py  text diff=python
```

## Perl
```
*.pl  text diff=perl
*.pm  text diff=perl
```

## Ruby
```
*.rb  text diff=ruby
```

## Lua
```
*.lua  text
```

## Web
```
*.html    text diff=html
*.htm     text diff=html
*.xhtml   text diff=html
*.css     text diff=css
*.js      text
*.coffee  text
*.less    text
*.php     text diff=php
*.sass    text
*.scss    text diff=css
*.ts      text
```

## DB
```
*.sql  text
```

## Patches — preserve line endings
```
*.patch  -text
```

## Scripts
```
*.sh    text eol=lf diff=bash
*.bash  text eol=lf diff=bash
*.bat   text eol=crlf
*.cmd   text eol=crlf
*.ps1   text eol=crlf
*.psm1  text eol=crlf
```

## Make
```
Makefile  text eol=lf
*.mk      text eol=lf
```

## Docker
```
Dockerfile     text eol=lf
.dockerignore  text
```

## Vagrant
```
Vagrantfile  text diff=ruby
```

## Visual Studio
```
*.sln        text eol=crlf
*.csproj     text eol=crlf
*.vcxproj    text eol=crlf
*.vcproj     text eol=crlf
```

## Mathematica
```
*.nb   text diff=mathematica
*.wls  text diff=mathematica
*.wl   text diff=mathematica
*.m    text diff=mathematica
```

## Configs
```
*.ini   text
*.json  text
*.toml  text
*.xml   text
*.yaml  text
*.yml   text
```

## Documentation
```
*.md          text diff=markdown
*.txt         text
AUTHORS       text
CHANGELOG     text
CHANGES       text
CONTRIBUTING  text
COPYING       text
copyright     text
*COPYRIGHT*   text
INSTALL       text
license       text
LICENSE       text
NEWS          text
readme        text
*README*      text
TODO          text
```

## EditorConfig
```
.editorconfig  text
```

## Git
```
.gitattributes  text export-ignore
.gitignore      text export-ignore
.gitkeep        text export-ignore
.gitmodules     text export-ignore
```

# See Also
- [gitattibutes Documentation — Git](https://git-scm.com/docs/gitattributes)
- [alexkaratarakis/gitattributes — GitHub](https://github.com/alexkaratarakis/gitattributes "alexkaratarakis/gitattributes — GitHub")
