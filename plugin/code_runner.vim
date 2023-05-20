let g:vim_code_runner_last_n_commands=[]
let g:vim_code_runner_last_n_query_results=[]
let g:vim_code_runner_debug_label = "DEBUG-> "

command! VimCodeRunnerScratch new | setlocal bt=nofile bh=wipe nobl noswapfile nu

function _VimCodeRunnerRunPsql(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'pgsql' does not support this"
    echohl None
    return []
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _psql = 'psql '
  if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true')
    let _psql = _psql . '--csv '
    let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  endif
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  if (a:is_in_container)
    if (get(g:, 'use_runner_options_in_container', "false") == 'true')
      let _command_prepend = 'export PGDATABASE=' . $PGDATABASE . '; '
            \ . 'export PGUSER=' . $PGUSER . '; '
            \ . 'export PGPASSWORD=' . $PGPASSWORD . '; '
      let _command = _psql . '-c "' . _preped_text . '"'
    else
      let _command = _psql . "-c '" . _preped_text . "'"
    endif
  else
    if (g:vim_code_runer_debug == 'true')
      echo g:vim_code_runner_debug_label "local PG* configs that will be used since not running in a container:"
      echo g:vim_code_runner_debug_label "  export PGHOST=\"".$PGHOST."\";"
      echo g:vim_code_runner_debug_label "  export PGPORT=\"".$PGPORT."\";"
      echo g:vim_code_runner_debug_label "  export PGDATABASE=\"".$PGDATABASE."\";"
      echo g:vim_code_runner_debug_label "  export PGUSER=\"".$PGUSER."\";"
      echo g:vim_code_runner_debug_label "  export PGPASSWORD=\"".$PGPASSWORD."\";"
    endif
    let _command = _psql . "-c '" . _preped_text . "'"
  endif
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunMssql(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'mssql' does not support this"
    echohl None
    return []
  endif
  let _command_prepend = ''
  let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _mssql = 'sqlcmd -s"," ' . " -d '" . $SQLCMDDBNAME . "'" . " -U '" . $SQLCMDUSER . "'" . " -P '" . $SQLCMDPASSWORD . "'" . " -q '" . _preped_text . "'"
  if (a:is_in_container)
    let _command = _mssql
  else
    let _command = _mssql . " -S '" . $SQLCMDSERVER . "," . $SQLCMDPORT . "'"
  endif
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunMysql(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'mysql' does not support this"
    echohl None
    return []
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _mysql = 'mysql '. " --database='" . $MYSQLDATABASE . "'" . " --user='" . $MYSQLUSER . "'" . " --password='" . $MYSQLPASSWORD . "'" . " --execute='" . _preped_text . "'"
  if (a:is_in_container)
    let _command = _mysql
  else
    let _command = _mysql . " --host='" . $MYSQLHOST . "'" . " --port='" . $MYSQLPORT . "'"
  endif
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunMongoDb(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'mongodb' does not support this"
    echohl None
    return []
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _mongo = 'mongo '. " --database '" . $MONGODBDATABASE . "'" . " --user '" . $MONGODBUSER . "'" . " --password '" . $MONGODBPASSWORD . "'" . " --eval '" . _preped_text . "'"
  if (a:is_in_container)
    let _command = _mongo . $MONGODBDATABASE
  else
    let _command = _mongo . " --host '" . $MONGODBHOST . "/" . $MONGODBDATABASE . "'" . " --port '" . $MONGODBPORT . "'"
  endif
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunRedis(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'redis' does not support this"
    echohl None
    return []
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = raw_text
  let _redis = 'redis-cli '
  if (a:is_in_container)
    let _command = _redis . _preped_text
  else
    let _command = _redis . "-h '" . $REDISHOST . "'" . " -p '" . $REDISPORT . "' " . _preped_text
  endif
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunPython(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = "python -c '" . _preped_text . "'"
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunJavascript(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = "node -e '" . _preped_text . "'"
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunTypescript(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = "ts-node -e '" . _preped_text . "'"
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunPhp(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _php_open_tag_pattern = "^\n*\s*<\?php\s*"
  let _php_close_tag_pattern = "\s*?>\n*\s*"
  if match(_preped_text, _php_open_tag_pattern) >= 0
    let _preped_text = substitute(_preped_text, _php_open_tag_pattern, "", "")
    let _preped_text = substitute(_preped_text, _php_close_tag_pattern, "", "")
  endif
  let _command = "php -r '" . _preped_text . "'"
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunRuby(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = "ruby -e '" . _preped_text . "'"
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunPerl(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = "perl -e '" . _preped_text . "'"
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunSh(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = "sh -c '" . _preped_text . "'"
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function _VimCodeRunnerRunPwsh(selected_text, is_in_container)
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = "pwsh -command '" . _preped_text . "'"
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type]
endfunction

function! VimCodeRunnerRun(...)
  let run_type = get(a:, 1, '')
  let debug = get(a:, 2, 'false')
  let g:vim_code_runner_debug = debug
  let _default_file_type = "text"
  " assumes the selected text will be yanked into the t register prior to VimCodeRunnerRun
  let selected_text = @t
  if (g:vim_code_runer_debug == 'true')
    echo g:vim_code_runner_debug_label "selected_text: " selected_text
  endif
  let case_values = []
  let is_in_container = !empty(get(g:, 'container_name', "")) && trim(g:container_name) != ''
  let _should_bottom_split = 0
  let markdown_tag = ''
  if (&filetype == 'markdown')
    let _markdown_pattern = '^\n*\s*```\v(\w+)(.*)'
    let markdown_tag = substitute(selected_text, _markdown_pattern, '\=submatch(1)', '')
    if markdown_tag != ''
      let selected_text = substitute(selected_text, _markdown_pattern, '\=submatch(2)', '')
      let selected_text = substitute(selected_text, '\v(.*)```\n*\s*$', '\1', '')
    endif
  endif
  let file_ext = expand('%:e')
  " check file_extension
  if (file_ext == 'pgsql' || run_type == 'pgsql' || markdown_tag == 'pgsql')
    let run_path = "pgsql"
    let case_values = _VimCodeRunnerRunPsql(selected_text, is_in_container)
  elseif (file_ext == 'redis' || run_type == 'redis' || markdown_tag == 'redis')
    let run_path = "redis"
    let case_values = _VimCodeRunnerRunRedis(selected_text, is_in_container)
  elseif (file_ext == 'mongodb' || run_type == 'mongodb' || markdown_tag == 'mongodb')
    let run_path = "mongodb"
    let case_values = _VimCodeRunnerRunMongoDb(selected_text, is_in_container)
  elseif (file_ext == 'mssql' || run_type == 'mssql' || markdown_tag == 'mssql')
    let run_path = "mssql"
    let case_values = _VimCodeRunnerRunMssql(selected_text, is_in_container)
  elseif (file_ext == 'mysql' || run_type == 'mysql' || markdown_tag == 'mysql')
    let run_path = "mysql"
    let case_values = _VimCodeRunnerRunMysql(selected_text, is_in_container)
  elseif (&filetype == 'python' || run_type == 'python' || markdown_tag == 'python')
    let run_path = "python"
    let case_values = _VimCodeRunnerRunPython(selected_text, is_in_container)
  elseif (&filetype == 'javascript' || run_type == 'javascript' || markdown_tag == 'javascript')
    let run_path = "javascript"
    let case_values = _VimCodeRunnerRunJavascript(selected_text, is_in_container)
  elseif (&filetype == 'typescript' || run_type == 'typescript' || markdown_tag == 'typescript')
    let run_path = "typescript"
    let case_values = _VimCodeRunnerRunTypescript(selected_text, is_in_container)
  elseif (&filetype == 'php' || run_type == 'php' || markdown_tag == 'php')
    let run_path = "php"
    let case_values = _VimCodeRunnerRunPhp(selected_text, is_in_container)
  elseif (&filetype == 'ruby' || run_type == 'ruby' || markdown_tag == 'ruby')
    let run_path = "ruby"
    let case_values = _VimCodeRunnerRunRuby(selected_text, is_in_container)
  elseif (&filetype == 'perl' || run_type == 'perl' || markdown_tag == 'perl')
    let run_path = "perl"
    let case_values = _VimCodeRunnerRunPerl(selected_text, is_in_container)
  elseif (&filetype == 'sh' || run_type == 'sh' || markdown_tag == 'bash' || markdown_tag == 'shell')
    let run_path = "sh"
    let case_values = _VimCodeRunnerRunSh(selected_text, is_in_container)
  elseif (&filetype == 'ps1' || run_type == 'powershell' || markdown_tag == 'powershell')
    let run_path = "powershell"
    let case_values = _VimCodeRunnerRunPwsh(selected_text, is_in_container)
  else
    echohl WarningMsg
    echo "No matching run_path!"
    echohl None
  endif
  let _command = get(case_values, 0, '')
  let _should_bottom_split = get(case_values, 1, 0)
  let _command_prepend = get(case_values, 2, '')
  let _file_type = get(case_values, 3, _default_file_type)
  let _base_command = _command
  if (is_in_container)
    let container_type = get(g:, 'container_type', 'docker')
    let container_cli = "docker"
    if (container_type == "k8s")
      let container_cli = "kubectl"
    endif
    let _command = container_cli . " exec \"" . g:container_name . '" '
    if (container_type == "k8s")
      let _command = _command . "-- "
    endif
    if (!empty(get(l:, '_command_prepend', '')))
      let _shell_command = "sh -c '"
            \ . _command_prepend
            \ . _base_command
            \ . "'"
      let _command = _command . _shell_command
    else
      let _command = _command . _base_command
    endif
  endif
  if (trim(_base_command) == '')
    echohl WarningMsg
    echo "No _base_command could be generated for your specific use case"
    echo "run_path: " get(l:, 'run_path', '')
    echo "_base_command: " get(l:, '_base_command', '')
    echohl None
    return
  endif
  if (g:vim_code_runer_debug != 'true')
    let g:vim_code_runner_last_query_results = system(_command)
    let g:vim_code_runner_last_command = _command
    let g:vim_code_runner_last_n_query_results= [g:vim_code_runner_last_query_results] + g:vim_code_runner_last_n_query_results
    let g:vim_code_runner_last_n_commands = [g:vim_code_runner_last_command] + g:vim_code_runner_last_n_commands
    if (len(g:vim_code_runner_last_n_query_results) > get(g:, 'vim_code_runner_history_size', 10))
      let g:vim_code_runner_last_n_query_results= g:vim_code_runner_last_n_query_results[:-2]

    endif
    if (len(g:vim_code_runner_last_n_commands) > get(g:, 'vim_code_runner_history_size', 10))
      let g:vim_code_runner_last_n_commands= g:vim_code_runner_last_n_commands[:-2]
    endif
    if (_should_bottom_split)
      set splitbelow
      horizontal belowright VimCodeRunnerScratch
      put =g:vim_code_runner_last_query_results
      let &filetype = _file_type
      execute "normal! ggdd"
      set splitbelow!
    else
      put =g:vim_code_runner_last_query_results
    endif
  else
    echo g:vim_code_runner_debug_label "run_path: " run_path
    echo g:vim_code_runner_debug_label "container_type: " get(g:, 'container_type', '')
    echo g:vim_code_runner_debug_label "container_name: " get(g:, 'container_name', '')
    echo g:vim_code_runner_debug_label "_command: " _command
    echo g:vim_code_runner_debug_label "_command_prepend: " _command_prepend
    echo g:vim_code_runner_debug_label "_should_bottom_split: " _should_bottom_split
  endif
endfunction
