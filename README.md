# sync subtree repo action

it used to sync subtree repository from current repository

## Inputs

### `repo`
target repository
### `path`
current repository path to sync
### `force`
force push
### `branch`
target subtree repository

## Outputs

### `outputs`



## Example usage

```yaml
jobs:
  sync-sutree-repo:
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        path:
          - dir/dir

    name: Update subtree repo from ${{ matrix.path }}
    steps:
      - uses: actions/checkout@v2
        with:
          lfs: true
          fetch-depth: 10000
      - uses: elanworld/subtree-sync-action@v1.0
        with:
          path: '${{ matrix.path }}'
          repo_token: ${{ secrets.REPO_TOKEN }}
          force: false
```


tip: `github checkout acion fetch-depth recommand be a number gather than repository commit`
