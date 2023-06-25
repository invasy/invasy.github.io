---
title: How to install a specific version of Python
categories:
- how to
tags:
- Bash
- Python
- Linux
- Ubuntu
- Debian
- APT
- checkinstall
- getopt
---
# Prerequisites
- Bash
- git
- C compiler
  - GCC
  - clang
- make
- nproc (coreutils)
- checkinstall

## Ubuntu
```bash
sudo apt-get -y build-dep python3
sudo apt-get -y install checkinstall git pkg-config
```

# Script
```bash
install_python() {
  local -r repo_url='https://github.com/python/cpython.git'
  local -r repo_dir='/tmp/cpython'
  local args descr name email

  args="$(getopt --options 'd:n:e:' --longoptions 'description:,name:,email:' -- "$@")"
  (( $? == 0 )) || return "$?"
  eval set -- "$args"
  while true; do
    case $1 in
      -d|--description) descr="$2"; shift ;;
      -n|--name) name="$2"; shift ;;
      -e|--email) email="$2"; shift ;;
      --) shift; break ;;
    esac
    shift
  done

  local version="${1:?}"
  local -a checkinstall_args=(
    --strip
    --pkgname="python${version%.*}"
    --pkgversion="$version"
    --provides="python-$version"
  )
  if [[ $name ]]; then
    local maintainer="$name"
    if [[ $email ]]; then
      maintainer+=" \\<$email\\>"
    fi
    checkinstall_args+=(--maintainer="$maintainer")
  fi

  git clone --branch="v$version" --single-branch --depth=1 -- "$repo_url" "$repo_dir"
  pushd "$repo_dir"
  ./configure --prefix=/usr --enable-optimizations
  make -s -j$(nproc) build_all
  echo -e "${description:-Python $version}" > description-pak
  sudo checkinstall "${checkinstall_args[@]}" make altinstall
  popd
  rm -rf "$repo_dir"
}
```

## Usage
```bash
name="$(git config --get user.name)"
email="$(git config --get user.email)"
install_python --name="$name" --email="$email" 3.6.7
```
