---
title: Debian changelog format
categories:
- reference
tags:
- changelog
- Debian
- syntax
- format
- documentation
- RFC2822
- RFC5322
---
# Changelog
`debian/changelog` — dpkg source packages' changelog file — list of entries in reversed chronological order.

Must be encoded in UTF-8.

## Entry
```
package (version) distributions; metadata

  * change-details
    more-change-details

  * even-more-change-details

 -- maintainer-name <email>  date
```

- `package` — package name;
- `version` — package version number;
- `distributions` — space-separated list of distributions where this package should be installed;
- `metadata` — comma-separated list of `key=value` items:
  - `urgency` — for `Urgency` field in `.changes` file;
  - `binary-only` — with a `yes` value denotes a binary-only upload (see man);
- `change-details` — change description;
  - must start with **at least 2 spaces**;
  - should have an asterisk after spaces for every change (by convention);
  - may be separated by blank lines;
  - if bug was resolved description may contain text according regexp `/closes:\s*(?:bug)?\#?\s?\d+(?:,\s*(?:bug)?\#?\s?\d+)*/i`{.perl};
- `maintainer` and `email` — name and email of a maintainer who made this change;
  - this line must start with **exactly 1 space**;
- `date` — date and time this change was made;
  - must be separated from `maintainer` and `email` by **exactly 2 spaces**;
  - format see below.

## Date
- Format: `day-of-week, dd month yyyy hh:mm:ss +zzzz`.
- `strftime` format: `"%a, %d %b %Y %H:%M:%S %z"` (with `LC_TIME=C`).

### Perl
```perl
#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(say);
use locale;
use POSIX qw(locale_h);
use Time::Piece;

setlocale(LC_TIME, 'C');
my $date = localtime->strftime('%a, %d %b %Y %H:%M:%S %z');
say($date);
```

### Shell
```bash
LANG=C date -R
```

# See Also
- [deb-changelog(5)](https://manpages.debian.org/testing/dpkg-dev/deb-changelog.5.en.html)
- [[Date and Time Formats]]
