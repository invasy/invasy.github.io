---
title: How to parse command line arguments in Bash
categories:
- how to
tags:
- Bash
- command line
- getopts
- getopt
---
# Overview

|                | `getopts`       | `getopt`             |
|----------------|:---------------:|:--------------------:|
| Implementation | builtin (POSIX) | `util-linux` package |
| Short options  | ✅︎              | ✅︎                   |
| Long options   | ❌              | ✅︎                   |
| Parsing        | one by one      | all at once          |
| Quiet mode     | `OPTERR=0`      | `-q \| --quiet`      |

# `getopts`

[`getopts`][getopts] — Bash builtin command.

## Example

```bash
parse_args() {
  local OPT OPTARG
  local -i OPTIND=1 OPTERR=0
  # shellcheck disable=SC2220
  while getopts ':a:bvVh' OPT; do
    case $OPT in
      a) arg1="$OPTARG" ;;
      b) arg2=1 ;;
      v) verbose=1 ;;
      V) show_version; exit 0 ;;
      h) show_usage; exit 0 ;;
      :) echo "missing argument for option -$OPTARG" >&2; exit 3 ;;
      *) echo "invalid option -$OPTARG" >&2; exit 2 ;;
    esac
  done; shift $(( OPTIND - 1 ))
}
```

## Error handling

- by `getopts` itself:
  - no setup needed
  - prints error message
  - returns error code (`$? != 0`)
- manually (_silent mode_):
  - setup:
    - set `OPTERR=0`
    - _or_ add `:` to the beginning of `optstring`, e. g. `:a:bh`
  - `OPT == '?'` — invalid option
  - `OPT == ':'` — missing argument

# `getopt`

[`getopt`][getopt] — parse command options (enhanced), part of the [`util-linux`][util-linux] package.

## Example

```bash
declare -ir VERBOSE_MIN=0 VERBOSE_MAX=3
declare -r opt='a:bqvVh'
declare -ar long=(
  option-a:
  option-b
  quiet
  verbose
  version
  help
)
declare args a
declare -i b
args="$(IFS=','; getopt --name="${0##*/}" --opt="$opt" --long="${long[*]}" -- "$@")" || exit "$?"
eval set -- "$args"
while true; do
  case $1 in
    -a|--option-a) a="$2"; shift ;;
    -b|--option-b) b=1 ;;
    -q|--quiet) (( verbose > VERBOSE_MIN )) && (( --verbose )) ;;
    -v|--verbose) (( verbose < VERBOSE_MAX )) && (( ++verbose )) ;;
    -V|--version) show_version; exit 0 ;;
    -h|--help) show_usage; exit 0 ;;
    --) shift; break ;;
  esac
  shift
done
# ...
```

[getopts]: https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#index-getopts "getopts — Bash Reference Manual"
[getopt]: https://man7.org/linux/man-pages/man1/getopt.1.html "man 1 getopt"
[util-linux]: https://github.com/util-linux/util-linux
