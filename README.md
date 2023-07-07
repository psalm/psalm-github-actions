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
        uses: docker://ghcr.io/psalm/psalm-github-actions

```

## Specify Psalm version

You can also specify a version (after 3.14.2).

```diff
       - name: Psalm
-        uses: docker://ghcr.io/psalm/psalm-github-actions
+        uses: docker://ghcr.io/psalm/psalm-github-actions:5.7.7
```

## Use Security Analysis

Psalm supports [Security Analysis](https://psalm.dev/docs/security_analysis/). You can use this config to show security analysis reports:

```diff
       - name: Psalm
         uses: docker://ghcr.io/psalm/psalm-github-actions
+        with:
+          security_analysis: true
```

### Send security output to GitHub Security tab

GitHub also allows you to [send security issues to a separate part of the site](https://docs.github.com/en/free-pro-team@latest/github/finding-security-vulnerabilities-and-errors-in-your-code/sarif-support-for-code-scanning) that can be restricted to members of your team.

Use the following config:

```diff
       - name: Psalm
         uses: docker://ghcr.io/psalm/psalm-github-actions
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
         uses: docker://ghcr.io/psalm/psalm-github-actionsa
+        with:
+          composer_require_dev: true
+          composer_ignore_platform_reqs: true
```

### Use relative dir

If your composer file is not in the directory, you can specify the relative directory.

Use the following config:

```diff
       - name: Psalm
         uses: docker://ghcr.io/psalm/psalm-github-actions
+        with:
+          relative_dir: ./subdir
```

If you also want to send the issues to GitHub Security tab with a relative dir, you'll need to update the following step.

```diff
       - name: Upload Security Analysis results to GitHub
         uses: github/codeql-action/upload-sarif@v1
         with:
-          sarif_file: results.sarif
+          sarif_file: subdir/results.sarif
+          checkout_path: subdir
```


Auth for private composer repositories
-------------------------------
If you have private composer dependencies, SSH authentication must be used. Generate an SSH key pair for this purpose and add it to your private repository's configuration, preferable with only read-only privileges. On Github for instance, this can be done by using [deploy keys][deploy-keys].

Add the key pair to your project using  [Github Secrets][secrets], and pass them into this action by using the `ssh_key` and `ssh_key_pub` inputs. If your private repository is stored on another server than github.com, you also need to pass the domain via `ssh_domain`.

Example:

```yaml
jobs:
  build:

    ...

    - name: Psalm
      uses: docker://ghcr.io/psalm/psalm-github-actions
      with:
        ssh_key: ${{ secrets.SOME_PRIVATE_KEY }}
        ssh_key_pub: ${{ secrets.SOME_PUBLIC_KEY }}
        # Optional:
        ssh_domain: my-own-github.com 
```

github.com, gitlab.com and bitbucket.org are automatically added to the list of SSH known hosts. You can provide your own domain via `ssh_domain` input.
