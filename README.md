# code_runner.vim

A vim/neovim plugin to run selected chunks of code or whole files. Can run locally or within docker or k8s containers

Use cases:
- light weight database client by executing chunks of code and respecting db env vars
- execute tagged code blocks in markdown files
- execute chunks of code or whole files for script langages

## Examples:

### SQL Client:

![SQL_CLIENT_GIF](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYzY5ODIxMzdkOTc1MjIwZmQwY2M5MDdmNDcxYjE2OGQ5NDQwMDY2NSZlcD12MV9pbnRlcm5hbF9naWZzX2dpZklkJmN0PWc/aECxRS51f1kZ1lstQN/giphy.gif)

### Markdown and Code files:

![MARKDOWN_AND_CODE_FILES]( https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNWQ5ZjNiM2U1NmMzOTVhNTYzOWVkZDZlMTMxYWQwYjc0ZDUxY2I0YSZlcD12MV9pbnRlcm5hbF9naWZzX2dpZklkJmN0PWc/EjSlgTi4JGwnpqV3OR/giphy.gif)

## Supported editors
- vim
- neovim

## Supported Runners (in order of runner search)

### Extra condition for .sh files that can redirect to other runners

If your `.sh` file starts with a shebang to use a different command and you select that line (or run the whole shell file), then an attempt to use said program will occur instead of using `sh`.

<table style="width:100%">

  <tr>
    <th>Runner</th>
    <th>Command</th>
  </tr>

  <tr>
    <td>sh</td>
    <td>sh</td>
  </tr>

  <tr>
    <td>pgsql</td>
    <td>psql</td>
  </tr>

  <tr>
    <td>redis</td>
    <td>redis-cli</td>
  </tr>

  <tr>
    <td>sqlite</td>
    <td>sqlite3</td>
  </tr>

  <tr>
    <td>mongodb</td>
    <td>mongo</td>
  </tr>

  <tr>
    <td>mssql**(EXPERIMENTAL/UNTESTED)**</td>
    <td>sqlcmd</td>
  </tr>

  <tr>
    <td>mysql</td>
    <td>mysql</td>
  </tr>

  <tr>
    <td>zsh</td>
    <td>zsh</td>
  </tr>

  <tr>
    <td>bash</td>
    <td>bash</td>
  </tr>

  <tr>
    <td>cmd</td>
    <td>bat</td>
  </tr>

  <tr>
    <td>python</td>
    <td>python</td>
  </tr>

  <tr>
    <td>javascript</td>
    <td>node</td>
  </tr>

  <tr>
    <td>typescript</td>
    <td>ts-node</td>
  </tr>

  <tr>
    <td>php</td>
    <td>php</td>
  </tr>

  <tr>
    <td>ruby</td>
    <td>ruby</td>
  </tr>

  <tr>
    <td>perl</td>
    <td>perl</td>
  </tr>

  <tr>
    <td>powershell</td>
    <td>pwsh</td>
  </tr>

</table>

### How a runner is selected

The following tags drive runner selection.
If a file extension, markdown tagged code block, shebang rediection matches then the associated runner will be used
NOTE: some runners also look at the &filetype. Denoted with a `" include set filetype=<lang>` at the end of the line below

```vim
let g:_vcr_sh_tags = ['sh', 'shell']
let g:_vcr_psql_tags = ['psql', 'pgsql']
let g:_vcr_redis_tags = ['redis', 'redis-cli']
let g:_vcr_sqlite_tags = ['sqlite', 'sqlite3']
let g:_vcr_mongodb_tags = ['mongodb', 'mongo']
let g:_vcr_mssql_tags = ['mssql', 'sqlcmd']
let g:_vcr_mysql_tags = ['mysql']
let g:_vcr_zsh_tags = ['zsh']
let g:_vcr_bash_tags = ['bash']
let g:_vcr_bat_tags = ['bat', 'cmd']
let g:_vcr_python_tags = ['python'] " include set filetype=python
let g:_vcr_javascript_tags = ['javascript', 'node'] " include set filetype=javascript
let g:_vcr_typescript_tags = ['typescript', 'ts-node'] " include set filetype=typescript
let g:_vcr_php_tags = ['php'] " include set filetype=php
let g:_vcr_perl_tags= ['perl'] " include set filetype=perl
let g:_vcr_ruby_tags= ['ruby'] " include set filetype=ruby
let g:_vcr_powershell_tags= ['ps1', 'powershell', 'pwsh'] " include set filetype=ps1
```

---

## Runner Options

```vim
" will run in the container if this is set to non empty string (Default: unset)
let container_name="container_name" |
" specify what kind of container you want to run in. Valid choices: ["docker", "k8s"] (Default: docker)
let container_type="docker"
" will use specific runner env vars (if applicable) in the container (Default: false)
let use_runner_options_in_container="true" |
" Recommend using 'mechatroner/rainbow_csv' for the 'rfc_csv' filetype  (Default: csv)
let vim_code_runner_csv_type="rfc_csv" |
" will decide if sql output will be in csv format or the default for the sql cli tool being used (Default: true)
let vim_code_runner_sql_as_csv="true" |
" the number of  commands and query results saved (Default: 10) for array size of vim_code_runner_last_n_query_results
let vim_code_runner_history_size="10" |
" A label that will be prepended to all debug logs (Default: "DEBUG-> ")
let vim_code_runner_debug_label = "DEBUG-> " |
```

### Specific Runner Options

#### psql

```vim
" the following are used only when container_name is not set
let $PGHOST="127.0.0.1" |
let $PGPORT="5432" |
" the following are used regardless
let $PGDATABASE="postgres" |
let $PGUSER="postgres" |
let $PGPASSWORD="password" |
```

#### sqlite

`let use_runner_options_in_container='false' |` is not supported

```vim
" the following are used only when container_name is not set
let $SQLITEDBFILE="./main.sqlite" |
```

#### mssql

`let vim_code_runner_sql_as_csv='false' |` is not supported

`let use_runner_options_in_container='false' |` is not supported

```vim
" the following are used only when container_name is not set
let $SQLCMDSERVER="127.0.0.1" |
let $SQLCMDPORT="5432" |
" the following are used regardless
let $SQLCMDDBNAME="mssql" |
let $SQLCMDUSER="mssql" |
let $SQLCMDPASSWORD="password" |
```

#### mysql

`let use_runner_options_in_container='false' |` is not supported

```vim
let $MYSQLHOST="127.0.0.1" |
let $MYSQLPORT="5432" |
let $MYSQLDATABASE="mysql" |
let $MYSQLUSER="mysql" |
let $MYSQLPASSWORD="password" |
```

#### mongodb

`let use_runner_options_in_container='false' |` is not supported

```vim
let $MONGODBHOST="127.0.0.1" |
let $MONGODBPORT="5432" |
let $MONGODBUSER="mongodb" |
let $MONGODBPASSWORD="password" |
```

#### redis

`let use_runner_options_in_container='false' |` is not supported

```vim
let $REDISHOST="127.0.0.1" |
let $REDISPORT="6379" |
```

## Recommended Keybindings

The t register is used to get the selected_text and use in the Run command

NOTE: the clearing of the t register at the beginning of the whole file commands is important to clean up state for running whole files

```vim
" runs the selected_text with the determined run_type
vmap <leader>5 "ty:call VimCodeRunnerRun()<CR>
" dry run / debug what VimCodeRunnerRun() will do in a real run
vmap <leader>4 "ty:call VimCodeRunnerRun('', 'true')<CR>
" run whole file if run_type supports it
nmap <leader>5 :let @t = ''<CR>:call VimCodeRunnerRun()<CR>
" dry run / debug whole file if run_type supports it
nmap <leader>4 :let @t = ''<CR>:call VimCodeRunnerRun('', 'true')<CR>
```

## Tips

### I closed the results of my last query and the query takes a large amount of time to run.

there is a global variable called vim_code_runner_last_query_result; it stores the results of your last query

use something like this command to get the content out of the variable
```vim
" in visual mode with a blank line selected
put =g:vim_code_runner_last_query_result
```

you can view even further back depending on your vim_code_runner_history_size setting with vim_code_runner_last_n_query_results list

## Contribution Requests

requesting MRs for other code runners
if they have specific runner env vars, then also update VimCodeRunnerRunConfigs to include a case for it

- some other sql???
- some other nosql???
