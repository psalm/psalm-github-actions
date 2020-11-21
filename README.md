# Psalm Github action

Run Psalm as a github action.

```yaml
name: Psalm Static analysis

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

## Specify Psalm version

You can also specify a version (after 3.14.2).

```diff
       - name: Psalm
-        uses: docker://vimeo/psalm-github-actions
+        uses: docker://vimeo/psalm-github-actions:3.14.2
```

## Use Security Analysis

Psalm supports [Security Analysis](https://psalm.dev/docs/security_analysis/). You can use this config to show security analysis reports:

```diff
       - name: Psalm
         uses: docker://vimeo/psalm-github-actions
+        with:
+          security_analysis: true
```

### Send security output to GitHub Security tab

GitHub also allows you to [send security issues to a separate part of the site](https://docs.github.com/en/free-pro-team@latest/github/finding-security-vulnerabilities-and-errors-in-your-code/sarif-support-for-code-scanning) that can be restricted to members of your team.

Use the following config:

```diff
       - name: Psalm
         uses: docker://vimeo/psalm-github-actions
+        with:
+          security_analysis: true
+          report_file: results.sarif
+      - name: Upload Security Analysis results to GitHub
+        uses: github/codeql-action/upload-sarif@v1
+        with:
+          sarif_file: results.sarif
```

## Customising Composer

Specify `composer_require_dev: true` to install dev dependencies and `composer_ignore_platform_reqs: true` in order to ignore platform requirements.

These are both set to false by default.

```diff
       - name: Psalm
         uses: docker://vimeo/psalm-github-actions
+        with:
+          composer_require_dev: true
+          composer_ignore_platform_reqs: true
```
