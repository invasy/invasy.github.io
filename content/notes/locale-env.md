---
title: Locale environment variables in Linux
categories:
- cheatsheet
tags:
- linux
- locale
- env
- LANG
- LC_ALL
---
Run the following command to show current locale variables:
```bash
locale
```

## Variables

- `LANG='ru_RU.UTF-8'` — language/locale to use
- `LANGUAGE='ru_RU:en_US'` — `:`-separated list of languages
- `LC_*` — override `LANG`:
  - `LC_CTYPE='ru_RU.UTF-8'` — interpretation of byte sequences as characters
  - `LC_NUMERIC='ru_RU.UTF-8'` — number formatting
  - `LC_TIME='ru_RU.UTF-8'` — date and time formatting
  - `LC_COLLATE='ru_RU.UTF-8'` — collation rules for sorting and regular expressions
  - `LC_MONETARY='ru_RU.UTF-8'` — currency formatting
  - `LC_MESSAGES='en_US.UTF-8'` — messages from CLI commands
  - `LC_PAPER='ru_RU.UTF-8'` — standard paper sizes
  - `LC_NAME='ru_RU.UTF-8'` — names formatting
  - `LC_ADDRESS='ru_RU.UTF-8'` — postal address formatting
  - `LC_TELEPHONE='ru_RU.UTF-8'` — phone number formatting
  - `LC_MEASUREMENT='ru_RU.UTF-8'` — measurement system
  - `LC_IDENTIFICATION='ru_RU.UTF-8'` — metadata for the locale
  - `LC_ALL=` — override all other variables except `LANGUAGE`
