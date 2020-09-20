# Psalm Github action

Run Psalm as a github action.

```yaml
name: Static analysis

on: [push, pull_request]

jobs:
  psalm:
    name: Psalm
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Psalm
        uses: docker://vimeo/psalm-github-actions

```

You can also specify a version (after 3.14.2).

```diff
       - name: Psalm
-        uses: docker://vimeo/psalm-github-actions
+        uses: docker://vimeo/psalm-github-actions:3.14.2
```