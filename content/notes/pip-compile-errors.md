---
title: How to debug pip-compile errors
categories:
- how to
tags:
- piptools
- pip-compile
- error
---
## When
```bash
pip-compile pyproject.toml
```

## What
Error with the following message:
```
Backend subprocess exited when trying to invoke prepare_metadata_for_build_wheel
Failed to parse .../pyproject.toml
```

## How to debug
Change `subprocess_runner` from `quiet` to `default` to show verbose log:

```diff {title="util.diff"}
--- a/lib/python3.11/site-packages/build/util.py	2023-04-03 18:16:13.713254111 +0500
+++ b/lib/python3.11/site-packages/build/util.py	2023-04-03 18:12:29.242171354 +0500
@@ -41,9 +41,9 @@
                      there.
     """
     builder = build.ProjectBuilder(
         os.fspath(srcdir),
-        runner=pyproject_hooks.quiet_subprocess_runner,
+        runner=pyproject_hooks.default_subprocess_runner,
     )
 
     if not isolated:
         return _project_wheel_metadata(builder)
```
