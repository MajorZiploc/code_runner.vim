let g:vim_code_runner_last_n_commands=[]
let g:vim_code_runner_last_n_query_results=[]
let g:vim_code_runner_debug_label = "DEBUG-> "

command! VimCodeRunnerScratch new | setlocal bt=nofile bh=wipe nobl noswapfile nu

function _VCR_RunBasic(selected_text, root_command, run_path)
  let run_path = a:run_path
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = a:root_command . " '" . _preped_text . "'"
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
endfunction

function _VCR_RunPsql(selected_text, is_in_container)
  let run_path = "pgsql"
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'pgsql' does not support this"
    echohl None
    return ['', '', '', '', l:run_path]
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
    if (g:vim_code_runner_debug == 'true')
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
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
endfunction

function _VCR_RunSqlite(selected_text, is_in_container)
  let run_path = "sqlite"
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'sqlite' does not support this"
    echohl None
    return ['', '', '', '', l:run_path]
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _sqlite = 'sqlite3 ' . $SQLITEDBFILE
  if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true')
    let _sqlite = _sqlite . ' -separator ","'
    let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  else
    let _sqlite = _sqlite . ' -column'
  endif
  let _sqlite = _sqlite . ' -header ' . "-cmd '" . _preped_text . "' .quit"
  let _command = _sqlite
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
endfunction

function _VCR_RunMssql(selected_text, is_in_container)
  let run_path = "mssql"
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'mssql' does not support this"
    echohl None
    return ['', '', '', '', l:run_path]
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
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
endfunction

function _VCR_RunMysql(selected_text, is_in_container)
  let run_path = "mysql"
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'mysql' does not support this"
    echohl None
    return ['', '', '', '', l:run_path]
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
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
endfunction

function _VCR_RunMongoDb(selected_text, is_in_container)
  let run_path = "mongodb"
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'mongodb' does not support this"
    echohl None
    return ['', '', '', '', l:run_path]
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
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
endfunction

function _VCR_RunRedis(selected_text, is_in_container)
  let run_path = "redis"
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    echohl WarningMsg
    echo "No selected_text stored in the t register! run_type: 'redis' does not support this"
    echohl None
    return ['', '', '', '', l:run_path]
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
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
endfunction

function _VCR_RunPhp(selected_text)
  let run_path = "php"
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
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
endfunction

function _VCR_RunSh(selected_text, is_in_container, shebang_lang_pass)
  let run_path = "sh"
  let raw_text = a:selected_text
  let shebang_lang_pass = get(a:, 'shebang_lang_pass', 'false')
  let is_in_container = get(a:, 'is_in_container', 'false')
  if (shebang_lang_pass != 'true' && trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let does_begin_with_shebang = match(raw_text, '^#!')
  if (does_begin_with_shebang >= 0)
    let shebang_lang_pattern = '^#![^\n]*[/ ]\v(\w+)(.*)'
    let shebang_lang = substitute(raw_text, shebang_lang_pattern, '\=submatch(1)', '')
    if (shebang_lang != '')
      let selected_text_override = substitute(raw_text, shebang_lang_pattern, '\=submatch(2)', '')
      if (selected_text_override != '')
        if (g:vim_code_runner_debug)
          echo g:vim_code_runner_debug_label "trying to run with shebang_lang: " shebang_lang
        endif
        let shebang_lang_pass = 'true'
        let file_ext = ''
        let run_type = shebang_lang
        let markdown_tag = ''
        let case_values = _VCR_RunCases(file_ext, run_type, markdown_tag, selected_text_override, is_in_container, shebang_lang_pass)
        return case_values
      endif
    endif
  else
    let _command_prepend = ''
    let _file_type = 'log'
    let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
    let _command = "sh -c '" . _preped_text . "'"
    let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
  endif
endfunction

function _VCR_RunBat(selected_text)
  let run_path = "bat"
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    execute 'normal! ggVG"ty'
    let raw_text = @t
  endif
  let _command_prepend = ''
  let _file_type = 'log'
  let _preped_text = raw_text
  let _command = 'cmd /C "' . _preped_text . '"'
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
endfunction

function _VCR_RunZsh(selected_text)
  let run_path = "zsh"
  let root_command = "zsh -c"
  return _VCR_RunBasic(a:selected_text, root_command, run_path)
endfunction

function _VCR_RunBash(selected_text)
  let run_path = "bash"
  let root_command = "bash -c"
  return _VCR_RunBasic(a:selected_text, root_command, run_path)
endfunction

function _VCR_RunPython(selected_text)
  let run_path = "python"
  let root_command = "python -c"
  return _VCR_RunBasic(a:selected_text, root_command, run_path)
endfunction

function _VCR_RunJavascript(selected_text)
  let run_path = "javascript"
  let root_command = "node -e"
  return _VCR_RunBasic(a:selected_text, root_command, run_path)
endfunction

function _VCR_RunTypescript(selected_text)
  let run_path = "typescript"
  let root_command = "ts-node -e"
  return _VCR_RunBasic(a:selected_text, root_command, run_path)
endfunction

function _VCR_RunRuby(selected_text)
  let run_path = "ruby"
  let root_command = "ruby -e"
  return _VCR_RunBasic(a:selected_text, root_command, run_path)
endfunction

function _VCR_RunPerl(selected_text)
  let run_path = "perl"
  let root_command = "perl -e"
  return _VCR_RunBasic(a:selected_text, root_command, run_path)
endfunction

function _VCR_RunPwsh(selected_text)
  let run_path = "powershell"
  let root_command = "pwsh -command"
  return _VCR_RunBasic(a:selected_text, root_command, run_path)
endfunction

function! _VCR_IsLabelMemOf(actual_label, ...)
  for expected_label in a:000
    if (a:actual_label == expected_label)
      return 1
    endif
  endfor
  return 0
endfunction

function! _VCR_RunCases(file_ext, run_type, markdown_tag, selected_text, is_in_container, shebang_lang_pass)
  let file_ext = a:file_ext
  let run_type = a:run_type
  let markdown_tag = a:markdown_tag
  let selected_text = a:selected_text
  let is_in_container = a:is_in_container
  let shebang_lang_pass = a:shebang_lang_pass
  " check file_extension
  if (_VCR_IsLabelMemOf(run_type, 'sh') || (run_type == '' && (file_ext == 'sh' || markdown_tag == 'shell')))
    let case_values = _VCR_RunSh(selected_text, is_in_container, shebang_lang_pass)
  elseif (_VCR_IsLabelMemOf(run_type, 'pgsql', 'psql') || (run_type == '' && (_VCR_IsLabelMemOf(file_ext, 'pgsql', 'psql') || markdown_tag == 'pgsql' || markdown_tag == 'psql')))
    let case_values = _VCR_RunPsql(selected_text, is_in_container)
  elseif (_VCR_IsLabelMemOf(run_type, 'redis', 'redis-cli') || (run_type == '' && (file_ext == 'redis' || markdown_tag == 'redis')))
    let case_values = _VCR_RunRedis(selected_text, is_in_container)
  elseif (_VCR_IsLabelMemOf(run_type, 'sqlite', 'sqlite3') || (run_type == '' && (file_ext == 'sqlite' || markdown_tag == 'sqlite')))
    let case_values = _VCR_RunSqlite(selected_text, is_in_container)
  elseif (_VCR_IsLabelMemOf(run_type, 'mongodb', 'mongo') || (run_type == '' && (file_ext == 'mongodb' || markdown_tag == 'mongodb')))
    let case_values = _VCR_RunMongoDb(selected_text, is_in_container)
  elseif (_VCR_IsLabelMemOf(run_type, 'mssql', 'sqlcmd') || (run_type == '' && (file_ext == 'mssql' || markdown_tag == 'mssql')))
    let case_values = _VCR_RunMssql(selected_text, is_in_container)
  elseif (_VCR_IsLabelMemOf(run_type, 'mysql') || (run_type == '' && (file_ext == 'mysql' || markdown_tag == 'mysql')))
    let case_values = _VCR_RunMysql(selected_text, is_in_container)
  elseif (_VCR_IsLabelMemOf(run_type, 'zsh') || (run_type == '' && (file_ext == 'zsh' ||  markdown_tag == 'zsh')))
    let case_values = _VCR_RunZsh(selected_text)
  elseif (_VCR_IsLabelMemOf(run_type, 'bash') || (run_type == '' && (file_ext == 'bash' || markdown_tag == 'bash')))
    let case_values = _VCR_RunBash(selected_text)
  elseif (_VCR_IsLabelMemOf(run_type, 'cmd', 'bat') || (run_type == '' && (file_ext == 'bat' || markdown_tag == 'bat')))
    let case_values = _VCR_RunBat(selected_text)
  elseif (_VCR_IsLabelMemOf(run_type, 'python') || (run_type == '' && (&filetype == 'python' || markdown_tag == 'python')))
    let case_values = _VCR_RunPython(selected_text)
  elseif (_VCR_IsLabelMemOf(run_type, 'javascript', 'node') || (run_type == '' && (&filetype == 'javascript' || markdown_tag == 'javascript')))
    let case_values = _VCR_RunJavascript(selected_text)
  elseif (_VCR_IsLabelMemOf(run_type, 'typescript', 'ts-node') || (run_type == '' && (&filetype == 'typescript' || markdown_tag == 'typescript')))
    let case_values = _VCR_RunTypescript(selected_text)
  elseif (_VCR_IsLabelMemOf(run_type, 'php') || (run_type == '' && (&filetype == 'php' || markdown_tag == 'php')))
    let case_values = _VCR_RunPhp(selected_text)
  elseif (_VCR_IsLabelMemOf(run_type, 'ruby') || (run_type == '' && (&filetype == 'ruby' || markdown_tag == 'ruby')))
    let case_values = _VCR_RunRuby(selected_text)
  elseif (_VCR_IsLabelMemOf(run_type, 'perl') || (run_type == '' && (&filetype == 'perl' || markdown_tag == 'perl')))
    let case_values = _VCR_RunPerl(selected_text)
  elseif (_VCR_IsLabelMemOf(run_type, 'powershell', 'pwsh') || (run_type == '' && (&filetype == 'ps1' || markdown_tag == 'powershell')))
    let case_values = _VCR_RunPwsh(selected_text)
  else
    let case_values = []
  endif
  return case_values
endfunction

function! VimCodeRunnerRun(...)
  let run_type = get(a:, 1, '')
  let debug = get(a:, 2, 'false')
  let shebang_lang_pass = 'false'
  let g:vim_code_runner_debug = debug
  let _default_file_type = "text"
  " assumes the selected text will be yanked into the t register prior to VimCodeRunnerRun
  let selected_text = @t
  if (g:vim_code_runner_debug == 'true')
    echo g:vim_code_runner_debug_label "selected_text: " selected_text
  endif
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
  let case_values = _VCR_RunCases(file_ext, run_type, markdown_tag, selected_text, is_in_container, shebang_lang_pass)
  let _command = get(case_values, 0, '')
  let _should_bottom_split = get(case_values, 1, 0)
  let _command_prepend = get(case_values, 2, '')
  let _file_type = get(case_values, 3, _default_file_type)
  let run_path = get(case_values, 4, '')
  if (run_path == '')
    echohl WarningMsg
    echo "No matching run_path!"
    echohl None
    return
  endif
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
  if (g:vim_code_runner_debug != 'true')
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
