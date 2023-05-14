# vim_code_runner

Run selected chunks of code. Can run locally or within docker containers

## Supported Runners

- postgresql (psql) - must be files saved as *.pgsql

The following are based on filetype
- python
- javascript
- typescript
- perl
- ruby

## Runner Options

```vim
" will run in the container if this is set to non empty string (Default: unset)
let container_name="container_name" |
" will use specific runner env vars (if applicable) in the container (Default: false)
let use_runner_options_in_container="true" |
" Recommend using 'mechatroner/rainbow_csv' for the 'rfc_csv' filetype  (Default: csv)
let vim_code_runner_csv_type="rfc_csv" |
```

### Specific Runner Options

#### psql

```vim
let $PGHOST="127.0.0.1" |
let $PGPORT="5432" |
let $PGDATABASE="postgres" |
let $PGUSER="postgres" |
let $PGPASSWORD="password" |
```

## Recommended Keybindings

The t register is used to get the selected_text and use in the Run command

```vim
" runs the selected_text with the determined run_type
vmap <leader>5 "ty:call VimCodeRunnerRun()<CR>
" dry run / debug what VimCodeRunnerRun() will do in a real run
vmap <leader>4 "ty:call VimCodeRunnerRun('', 'true')<CR>
```

## Contribution Requests

requesting MRs for other code runners
if they have specific runner env vars, then also update VimCodeRunnerRunConfigs to include a case for it

- mssql
- mysql
- some other sql???
