---
title: Wrap all methods of a class to suppress an error in Python
categories:
- interview
tags:
- Python
- decorator
- suppress
- exception
---
# Problem

Let there be an object with a lot of methods which can possibly raise some exception.

Desired behavior of those methods when exception occurs:
try to fix object and run method one more time.

# Solution

Wrap all the methods using a class decorator:

```python
#!/usr/bin/env python
import logging
from functools import wraps
from types import FunctionType


logger = logging.getLogger(__name__)


class NastyError(Exception):
    def __init__(self, arg: str) -> None:
        self.arg = arg

    def __str__(self) -> str:
        return f'Error with arg={self.arg}'


def nasty_function(arg):
    raise NastyError(arg)


def suppress_nasty_error(cls: type) -> type:
    def suppress_and_retry(method):
        @wraps(method)
        def wrapper(self, *args, **kwargs):
            try:
                method(self, *args, **kwargs)
            except NastyError as e:
                logger.warning('%s', str(e))
                ...  # FIXME: do something with the `self` object to fix the error
                method(self, *args, **kwargs)  # Try one last time

        return wrapper
    
    for name, attr in cls.__dict__.items():
        if isinstance(attr, FunctionType) and not name.startswith('__'):
            setattr(cls, name, suppress_and_retry(attr))

    return cls


@suppress_nasty_error
class A:
    def __init__(self, arg: str) -> None:
        self.arg = arg

    def __str__(self):
        return f'Object A with arg={self.arg}'

    def method1(self):
        if not self.arg:
            nasty_function(self.arg)
        print(f'arg={self.arg}')

    def method2(self, arg):
        nasty_function(arg)


if __name__ == '__main__':
    a = A('')
    a.method1()
    a.method2('')
```
