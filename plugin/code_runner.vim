let g:vim_code_runner_last_n_query_results=[]
let g:vim_code_runner_debug_label = "DEBUG-> "

command! VimCodeRunnerScratch new | setlocal bt=nofile bh=wipe nobl noswapfile nu

function! _VCR_CopyWholeFile()
  execute 'normal! ggVG"ty'
endfunction

function _VCR_RunBasic(selected_text, root_command, run_path)
  let run_path = a:run_path
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    let _ = _VCR_CopyWholeFile()
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
  let _command = 'psql '
  if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true')
    let _command = _command . '--csv '
    let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  endif
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  if (a:is_in_container)
    if (get(g:, 'use_runner_options_in_container', "false") == 'true')
      let _command_prepend = 'export PGDATABASE=' . $PGDATABASE . '; '
            \ . 'export PGUSER=' . $PGUSER . '; '
            \ . 'export PGPASSWORD=' . $PGPASSWORD . '; '
      let _command = _command . '-c "' . _preped_text . '"'
    else
      let _command = _command . "-c '" . _preped_text . "'"
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
    let _command = _command . "-c '" . _preped_text . "'"
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
  let _command = 'sqlite3 ' . $SQLITEDBFILE
  if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true')
    let _command = _command . ' -separator ","'
    let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  else
    let _command = _command . ' -column'
  endif
  let _command = _command . ' -header ' . "-cmd '" . _preped_text . "' .quit"
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
  let _command = 'sqlcmd -s"," ' . " -d '" . $SQLCMDDBNAME . "'" . " -U '" . $SQLCMDUSER . "'" . " -P '" . $SQLCMDPASSWORD . "'" . " -Q '" . _preped_text . "'"
  if (!a:is_in_container)
    let _command = _command . " -S '" . $SQLCMDSERVER . "," . $SQLCMDPORT . "'"
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
  let _command = 'mysql'
  if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true')
    let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  else
    let _command = _command . ' --table'
  endif
  if ($MYSQLDATABASE != '')
    let _command = _command . " --database='" . $MYSQLDATABASE . "'"
  endif
  if ($MYSQLUSER != '')
    let _command = _command . " --user='" . $MYSQLUSER . "'"
  endif
  if ($MYSQLPASSWORD != '')
    let _command = _command . " --password='" . $MYSQLPASSWORD . "'"
  endif
  let _command = _command . " --execute='" . _preped_text . "'"
  if (!a:is_in_container)
    let _command = _command . " --host='" . $MYSQLHOST . "'" . " --port='" . $MYSQLPORT . "'"
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
  let _command = 'mongo --quiet'
  if ($MONGODBUSER != '')
    let _command = _command . " -u '" . $MONGODBUSER . "'"
  endif
  if ($MONGODBPASSWORD != '')
    let _command = _command . " -p '" . $MONGODBPASSWORD . "'"
  endif
  let _command = _command . " --eval '" . _preped_text . "'"
  if (!a:is_in_container)
    let _command = _command . " --host '" . $MONGODBHOST . "'" . " --port '" . $MONGODBPORT . "'"
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
  let _command = 'redis-cli '
  if (a:is_in_container)
    let _command = _command . _preped_text
  else
    let _command = _command . "-h '" . $REDISHOST . "'" . " -p '" . $REDISPORT . "' " . _preped_text
  endif
  let _should_bottom_split = 1
  return [l:_command, l:_should_bottom_split, l:_command_prepend, l:_file_type, l:run_path]
endfunction

function _VCR_RunPhp(selected_text)
  let run_path = "php"
  let raw_text = a:selected_text
  if (trim(raw_text) == '')
    let _ = _VCR_CopyWholeFile()
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
    let _ = _VCR_CopyWholeFile()
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

function! _VCR_IsLabelMemOf(actual_label, expected_labels)
  for expected_label in a:expected_labels
    if (a:actual_label == expected_label)
      return 1
    endif
  endfor
  return 0
endfunction

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
let g:_vcr_python_tags = ['python']
let g:_vcr_javascript_tags = ['javascript', 'node']
let g:_vcr_typescript_tags = ['typescript', 'ts-node']
let g:_vcr_php_tags = ['php']
let g:_vcr_perl_tags= ['perl']
let g:_vcr_ruby_tags= ['ruby']
let g:_vcr_powershell_tags= ['ps1', 'powershell', 'pwsh']

function! _VCR_IsRunner(tags, run_type, file_ext, markdown_tag, filetype)
  if (get(a:, 'filetype', '') != '')
    return _VCR_IsLabelMemOf(a:run_type, a:tags) || (a:run_type == '' && (_VCR_IsLabelMemOf(a:file_ext, a:tags) || _VCR_IsLabelMemOf(a:markdown_tag, a:tags) || &filetype == a:filetype))
  else
    return _VCR_IsLabelMemOf(a:run_type, a:tags) || (a:run_type == '' && (_VCR_IsLabelMemOf(a:file_ext, a:tags) || _VCR_IsLabelMemOf(a:markdown_tag, a:tags)))
  endif
endfunction

function! _VCR_RunCases(file_ext, run_type, markdown_tag, selected_text, is_in_container, shebang_lang_pass)
  if (_VCR_IsRunner(g:_vcr_sh_tags, a:run_type, a:file_ext, a:markdown_tag, ''))
    let case_values = _VCR_RunSh(a:selected_text, a:is_in_container, a:shebang_lang_pass)
  elseif (_VCR_IsRunner(g:_vcr_psql_tags, a:run_type, a:file_ext, a:markdown_tag, ''))
    let case_values = _VCR_RunPsql(a:selected_text, a:is_in_container)
  elseif (_VCR_IsRunner(g:_vcr_redis_tags, a:run_type, a:file_ext, a:markdown_tag, ''))
    let case_values = _VCR_RunRedis(a:selected_text, a:is_in_container)
  elseif (_VCR_IsRunner(g:_vcr_sqlite_tags, a:run_type, a:file_ext, a:markdown_tag, ''))
    let case_values = _VCR_RunSqlite(a:selected_text, a:is_in_container)
  elseif (_VCR_IsRunner(g:_vcr_mongodb_tags, a:run_type, a:file_ext, a:markdown_tag, ''))
    let case_values = _VCR_RunMongoDb(a:selected_text, a:is_in_container)
  elseif (_VCR_IsRunner(g:_vcr_mssql_tags, a:run_type, a:file_ext, a:markdown_tag, ''))
    let case_values = _VCR_RunMssql(a:selected_text, a:is_in_container)
  elseif (_VCR_IsRunner(g:_vcr_mysql_tags, a:run_type, a:file_ext, a:markdown_tag, ''))
    let case_values = _VCR_RunMysql(a:selected_text, a:is_in_container)
  elseif (_VCR_IsRunner(g:_vcr_zsh_tags, a:run_type, a:file_ext, a:markdown_tag, ''))
    let case_values = _VCR_RunZsh(a:selected_text)
  elseif (_VCR_IsRunner(g:_vcr_bash_tags, a:run_type, a:file_ext, a:markdown_tag, ''))
    let case_values = _VCR_RunBash(a:selected_text)
  elseif (_VCR_IsRunner(g:_vcr_bat_tags, a:run_type, a:file_ext, a:markdown_tag, ''))
    let case_values = _VCR_RunBat(a:selected_text)
  elseif (_VCR_IsRunner(g:_vcr_python_tags, a:run_type, a:file_ext, a:markdown_tag, 'python'))
    let case_values = _VCR_RunPython(a:selected_text)
  elseif (_VCR_IsRunner(g:_vcr_javascript_tags, a:run_type, a:file_ext, a:markdown_tag, 'javascript'))
    let case_values = _VCR_RunJavascript(a:selected_text)
  elseif (_VCR_IsRunner(g:_vcr_typescript_tags, a:run_type, a:file_ext, a:markdown_tag, 'typescript'))
    let case_values = _VCR_RunTypescript(a:selected_text)
  elseif (_VCR_IsRunner(g:_vcr_php_tags, a:run_type, a:file_ext, a:markdown_tag, 'php'))
    let case_values = _VCR_RunPhp(a:selected_text)
  elseif (_VCR_IsRunner(g:_vcr_ruby_tags, a:run_type, a:file_ext, a:markdown_tag, 'ruby'))
    let case_values = _VCR_RunRuby(a:selected_text)
  elseif (_VCR_IsRunner(g:_vcr_perl_tags, a:run_type, a:file_ext, a:markdown_tag, 'perl'))
    let case_values = _VCR_RunPerl(a:selected_text)
  elseif (_VCR_IsRunner(g:_vcr_powershell_tags, a:run_type, a:file_ext, a:markdown_tag, 'ps1'))
    let case_values = _VCR_RunPwsh(a:selected_text)
  else
    let case_values = []
  endif
  return case_values
endfunction

function! _VCR_ResizeList(list, new_size)
  let new_list = a:list
  let size_diff = len(a:list) - a:new_size
  if (size_diff > 0)
    let slice_index = size_diff * -1 - 1
    let new_list = a:list[:slice_index]
  endif
  return new_list
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
    let query_results = system(_command)
    if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true' && _VCR_IsLabelMemOf(run_path, g:_vcr_mysql_tags))
      " HACK: to support mysql csv format
      let query_results = system("echo '" . query_results . "' | tr '\t' ','")
    endif
    let g:vim_code_runner_last_query_result = {
      \ 'result' : query_results,
      \ 'command' : _command
    \}
    let g:vim_code_runner_last_n_query_results= [g:vim_code_runner_last_query_result] + g:vim_code_runner_last_n_query_results
    let _runner_history_size_default = 10
    let _runner_history_size = get(g:, 'vim_code_runner_history_size', _runner_history_size_default)
    if (!(_runner_history_size =~# '^\d\+$' && _runner_history_size >= 1))
      let _runner_history_size = _runner_history_size_default
    endif
    let g:vim_code_runner_last_n_query_results = _VCR_ResizeList(g:vim_code_runner_last_n_query_results, _runner_history_size)
    if (_should_bottom_split)
      set splitbelow
      horizontal belowright VimCodeRunnerScratch
      put =query_results
      let &filetype = _file_type
      execute "normal! ggdd"
      set splitbelow!
    else
      put =query_results
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
