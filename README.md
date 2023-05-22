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
    <th>Condition for using this Runner</th>
  </tr>

  <tr>
    <td>sh</td>
    <td>sh</td>
    <td>_VCR_IsLabelMemOf(run_type, 'sh') || (run_type == '' && (file_ext == 'sh' || markdown_tag == 'shell'))</td>
  </tr>

  <tr>
    <td>pgsql</td>
    <td>psql</td>
    <td>_VCR_IsLabelMemOf(run_type, 'pgsql', 'psql') || (run_type == '' && (_VCR_IsLabelMemOf(file_ext, 'pgsql', 'psql') || markdown_tag == 'pgsql' || markdown_tag == 'psql'))</td>
  </tr>

  <tr>
    <td>redis</td>
    <td>redis-cli</td>
    <td>_VCR_IsLabelMemOf(run_type, 'redis', 'redis-cli') || (run_type == '' && (file_ext == 'redis' || markdown_tag == 'redis'))</td>
  </tr>

  <tr>
    <td>sqlite</td>
    <td>sqlite3</td>
    <td>_VCR_IsLabelMemOf(run_type, 'sqlite', 'sqlite3') || (run_type == '' && (file_ext == 'sqlite' || markdown_tag == 'sqlite'))</td>
  </tr>

  <tr>
    <td>mongodb</td>
    <td>mongo</td>
    <td>_VCR_IsLabelMemOf(run_type, 'mongodb', 'mongo') || (run_type == '' && (file_ext == 'mongodb' || markdown_tag == 'mongodb'))</td>
  </tr>

  <tr>
    <td>mssql**(EXPERIMENTAL/UNTESTED)**</td>
    <td>sqlcmd</td>
    <td>_VCR_IsLabelMemOf(run_type, 'mssql', 'sqlcmd') || (run_type == '' && (file_ext == 'mssql' || markdown_tag == 'mssql'))</td>
  </tr>

  <tr>
    <td>mysql**(EXPERIMENTAL/UNTESTED)**</td>
    <td>mysql</td>
    <td>_VCR_IsLabelMemOf(run_type, 'mysql') || (run_type == '' && (file_ext == 'mysql' || markdown_tag == 'mysql'))</td>
  </tr>

  <tr>
    <td>zsh</td>
    <td>zsh</td>
    <td>_VCR_IsLabelMemOf(run_type, 'zsh') || (run_type == '' && (file_ext == 'zsh' ||  markdown_tag == 'zsh'))</td>
  </tr>

  <tr>
    <td>bash</td>
    <td>bash</td>
    <td>_VCR_IsLabelMemOf(run_type, 'bash') || (run_type == '' && (file_ext == 'bash' || markdown_tag == 'bash'))</td>
  </tr>

  <tr>
    <td>cmd</td>
    <td>bat</td>
    <td>_VCR_IsLabelMemOf(run_type, 'cmd', 'bat') || (run_type == '' && (file_ext == 'bat' || markdown_tag == 'bat'))</td>
  </tr>

  <tr>
    <td>python</td>
    <td>python</td>
    <td>_VCR_IsLabelMemOf(run_type, 'python') || (run_type == '' && (&filetype == 'python' || markdown_tag == 'python'))</td>
  </tr>

  <tr>
    <td>javascript</td>
    <td>node</td>
    <td>_VCR_IsLabelMemOf(run_type, 'javascript', 'node') || (run_type == '' && (&filetype == 'javascript' || markdown_tag == 'javascript'))</td>
  </tr>

  <tr>
    <td>typescript</td>
    <td>ts-node</td>
    <td>_VCR_IsLabelMemOf(run_type, 'typescript', 'ts-node') || (run_type == '' && (&filetype == 'typescript' || markdown_tag == 'typescript'))</td>
  </tr>

  <tr>
    <td>php</td>
    <td>php</td>
    <td>_VCR_IsLabelMemOf(run_type, 'php') || (run_type == '' && (&filetype == 'php' || markdown_tag == 'php'))</td>
  </tr>

  <tr>
    <td>ruby</td>
    <td>ruby</td>
    <td>_VCR_IsLabelMemOf(run_type, 'ruby') || (run_type == '' && (&filetype == 'ruby' || markdown_tag == 'ruby'))</td>
  </tr>

  <tr>
    <td>perl</td>
    <td>perl</td>
    <td>_VCR_IsLabelMemOf(run_type, 'perl') || (run_type == '' && (&filetype == 'perl' || markdown_tag == 'perl'))</td>
  </tr>

  <tr>
    <td>powershell</td>
    <td>pwsh</td>
    <td>_VCR_IsLabelMemOf(run_type, 'powershell', 'pwsh') || (run_type == '' && (&filetype == 'ps1' || markdown_tag == 'powershell'))</td>
  </tr>

</table>

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
" the number of  commands and query results saved (Default: 10) for array sizes of vim_code_runner_last_n_commands and vim_code_runner_last_n_query_results
" NOTE: expected to be set in a vimrc or upfront before plugin use. Not expected to be change after using plugin for some time during a single vim session
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

`let vim_code_runner_sql_as_csv='false' |` is not supported

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

there is a global variable called vim_code_runner_last_query_results; it stores the results of your last query

use something like this command to get the content out of the variable
```vim
" in visual mode with a blank line selected
put =g:vim_code_runner_last_query_results
```

get the associated command that generated vim_code_runner_last_query_results with the global variable vim_code_runner_last_command in a similar fashion

you can view even further back depending on your vim_code_runner_history_size setting with vim_code_runner_last_n_commands and vim_code_runner_last_n_query_results lists

## Contribution Requests

requesting MRs for other code runners
if they have specific runner env vars, then also update VimCodeRunnerRunConfigs to include a case for it

- some other sql???
- some other nosql???
