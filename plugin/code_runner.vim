let g:vim_code_runner_last_n_query_results = []
let g:vim_code_runner_debug_label = "DEBUG-> "
let g:vim_default_file_type = 'log'

let g:_vcr_sh_tags = ['sh', 'shell']
let g:_vcr_psql_tags = ['psql', 'pgsql']
let g:_vcr_redis_tags = ['redis', 'redis-cli']
let g:_vcr_sqlite_tags = ['sqlite', 'sqlite3']
let g:_vcr_mongodb_tags = ['mongodb', 'mongo']
let g:_vcr_mssql_tags = ['mssql', 'sqlcmd']
let g:_vcr_mysql_tags = ['mysql']
let g:_vcr_mariadb_tags = ['mariadb']
let g:_vcr_cassandra_tags = ['cassandra']
let g:_vcr_neo4j_tags = ['neo4j']
let g:_vcr_zsh_tags = ['zsh']
let g:_vcr_bash_tags = ['bash']
let g:_vcr_bat_tags = ['bat', 'cmd']
let g:_vcr_python_tags = ['python']
let g:_vcr_javascript_tags = ['javascript', 'node', 'js']
let g:_vcr_typescript_tags = ['typescript', 'ts-node', 'ts']
let g:_vcr_php_tags = ['php']
let g:_vcr_perl_tags = ['perl', 'pl']
let g:_vcr_ruby_tags = ['ruby', 'rb']
let g:_vcr_powershell_tags = ['ps1', 'powershell', 'pwsh']

let g:vim_code_runner_runner_configs = [
  \ {
  \ "run_types": g:_vcr_sh_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_sh_tags,
  \ "markdown_tags": g:_vcr_sh_tags,
  \ "command_builder_fn_name": '_VCR_RunSh',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_psql_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_psql_tags,
  \ "markdown_tags": g:_vcr_psql_tags,
  \ "command_builder_fn_name": '_VCR_RunPsql',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_redis_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_redis_tags,
  \ "markdown_tags": g:_vcr_redis_tags,
  \ "command_builder_fn_name": '_VCR_RunRedis',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_sqlite_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_sqlite_tags,
  \ "markdown_tags": g:_vcr_sqlite_tags,
  \ "command_builder_fn_name": '_VCR_RunSqlite',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_mongodb_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_mongodb_tags,
  \ "markdown_tags": g:_vcr_mongodb_tags,
  \ "command_builder_fn_name": '_VCR_RunMongoDb',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_mssql_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_mssql_tags,
  \ "markdown_tags": g:_vcr_mssql_tags,
  \ "command_builder_fn_name": '_VCR_RunMssql',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_mariadb_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_mariadb_tags,
  \ "markdown_tags": g:_vcr_mariadb_tags,
  \ "command_builder_fn_name": '_VCR_RunMariaDb',
  \ "post_processor_fn_name": '_VCR_RunMysqlPostProcessor'
  \ },
  \ {
  \ "run_types": g:_vcr_cassandra_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_cassandra_tags,
  \ "markdown_tags": g:_vcr_cassandra_tags,
  \ "command_builder_fn_name": '_VCR_RunCassandra',
  \ },
  \ {
  \ "run_types": g:_vcr_neo4j_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_neo4j_tags,
  \ "markdown_tags": g:_vcr_neo4j_tags,
  \ "command_builder_fn_name": '_VCR_RunNeo4j',
  \ },
  \ {
  \ "run_types": g:_vcr_mysql_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_mysql_tags,
  \ "markdown_tags": g:_vcr_mysql_tags,
  \ "command_builder_fn_name": '_VCR_RunMysql',
  \ "post_processor_fn_name": '_VCR_RunMysqlPostProcessor'
  \ },
  \ {
  \ "run_types": g:_vcr_zsh_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_zsh_tags,
  \ "markdown_tags": g:_vcr_zsh_tags,
  \ "command_builder_fn_name": '_VCR_RunZsh',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_bash_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_bash_tags,
  \ "markdown_tags": g:_vcr_bash_tags,
  \ "command_builder_fn_name": '_VCR_RunBash',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_bat_tags,
  \ "file_types": [],
  \ "file_extensions": g:_vcr_bat_tags,
  \ "markdown_tags": g:_vcr_bat_tags,
  \ "command_builder_fn_name": '_VCR_RunBat',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_python_tags,
  \ "file_types": g:_vcr_python_tags,
  \ "file_extensions": g:_vcr_python_tags,
  \ "markdown_tags": g:_vcr_python_tags,
  \ "command_builder_fn_name": '_VCR_RunPython',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_javascript_tags,
  \ "file_types": g:_vcr_javascript_tags,
  \ "file_extensions": g:_vcr_javascript_tags,
  \ "markdown_tags": g:_vcr_javascript_tags,
  \ "command_builder_fn_name": '_VCR_RunJavascript',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_typescript_tags,
  \ "file_types": g:_vcr_typescript_tags,
  \ "file_extensions": g:_vcr_typescript_tags,
  \ "markdown_tags": g:_vcr_typescript_tags,
  \ "command_builder_fn_name": '_VCR_RunTypescript',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_php_tags,
  \ "file_types": g:_vcr_php_tags,
  \ "file_extensions": g:_vcr_php_tags,
  \ "markdown_tags": g:_vcr_php_tags,
  \ "command_builder_fn_name": '_VCR_RunPhp',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_ruby_tags,
  \ "file_types": g:_vcr_ruby_tags,
  \ "file_extensions": g:_vcr_ruby_tags,
  \ "markdown_tags": g:_vcr_ruby_tags,
  \ "command_builder_fn_name": '_VCR_RunRuby',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_perl_tags,
  \ "file_types": g:_vcr_perl_tags,
  \ "file_extensions": g:_vcr_perl_tags,
  \ "markdown_tags": g:_vcr_perl_tags,
  \ "command_builder_fn_name": '_VCR_RunPerl',
  \ "post_processor_fn_name": ''
  \ },
  \ {
  \ "run_types": g:_vcr_powershell_tags,
  \ "file_types": g:_vcr_powershell_tags,
  \ "file_extensions": g:_vcr_powershell_tags,
  \ "markdown_tags": g:_vcr_powershell_tags,
  \ "command_builder_fn_name": '_VCR_RunPowershell',
  \ "post_processor_fn_name": ''
  \ },
\ ]

let g:_vcr_split_styles_bottom = "bottom"

let g:_vcr_no_selected_text_warning = 'No selected_text given!'

command! VimCodeRunnerScratch new | setlocal bt=nofile bh=wipe nobl noswapfile nu

function! _VCR_RunBasic(args)
  let selected_text = a:args['selected_text']
  let root_command = a:args['root_command']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = root_command . " '" . _preped_text . "'"
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunPsql(args)
  let selected_text = a:args['selected_text']
  let is_in_container = a:args['is_in_container']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _command = 'psql '
  if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true')
    let _command = _command . '--csv '
    let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  endif
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _preped_text = substitute(_preped_text, '\$\$', "\\\\$\\\\$", "g")
  if (is_in_container)
    if ($PGDATABASE != '')
      let _command_prepend = _command_prepend . 'export PGDATABASE=' . $PGDATABASE . '; '
    endif
    if ($PGUSER != '')
      let _command_prepend = _command_prepend . 'export PGUSER=' . $PGUSER . '; '
    endif
    if ($PGPASSWORD != '')
      let _command_prepend = _command_prepend . 'export PGPASSWORD=' . $PGPASSWORD . '; '
    endif
    let _command = _command . '-c "' . _preped_text . '"'
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
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunSqlite(args)
  let selected_text = a:args['selected_text']
  let is_in_container = a:args['is_in_container']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _preped_text = substitute(_preped_text, '\$\$', "\\\\$\\\\$", "g")
  let _command = 'sqlite3 ' . $SQLITEDBFILE
  if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true')
    let _command = _command . ' -separator ","'
    let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  else
    let _command = _command . ' -column'
  endif
  let _command = _command . ' -header ' . "-cmd '" . _preped_text . "' .quit"
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunMssql(args)
  let selected_text = a:args['selected_text']
  let is_in_container = a:args['is_in_container']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _preped_text = substitute(_preped_text, '\$\$', "\\\\$\\\\$", "g")
  let _command = 'sqlcmd -s"," ' . " -d '" . $SQLCMDDBNAME . "'" . " -U '" . $SQLCMDUSER . "'" . " -P '" . $SQLCMDPASSWORD . "'" . " -Q '" . _preped_text . "'"
  if (!is_in_container)
    let _command = _command . " -S '" . $SQLCMDSERVER . "," . $SQLCMDPORT . "'"
  endif
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunMariaDb(args)
  let selected_text = a:args['selected_text']
  let is_in_container = a:args['is_in_container']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _preped_text = substitute(_preped_text, '\$\$', "\\\\$\\\\$", "g")
  let tmp_storage = '/tmp/mariadb.cnf'
  " NOTE: echo might vary based on container being run in, it may need echo -e
  let config_writer = get(g:, 'vim_code_runner_config_writer', 'echo')
  let _store_config = config_writer . " '"
    \ . '[client]'
    \ . '\nuser = ' . '"' . $MYSQLUSER . '"'
    \ . '\npassword = ' . '"' . $MYSQLPASSWORD . '"'
    \ . "' > " . tmp_storage . '; '
  let _command_prepend = substitute(_store_config, "'", "'\"'\"'", "g")
  let _command = 'mariadb --defaults-extra-file=' . tmp_storage
  if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true')
    let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  else
    let _command = _command . ' --table'
  endif
  if ($MYSQLDATABASE != '')
    let _command = _command . ' --database="' . $MYSQLDATABASE . '"'
  endif
  let _command = _command . ' --execute="' . _preped_text . '"'
  if (!is_in_container)
    let _command = _command . ' --host="' . $MYSQLHOST . '"' . ' --port="' . $MYSQLPORT . '"'
  endif
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunMysql(args)
  let selected_text = a:args['selected_text']
  let is_in_container = a:args['is_in_container']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _preped_text = substitute(_preped_text, '\$\$', "\\\\$\\\\$", "g")
  let tmp_storage = '/tmp/mysql.cnf'
  " NOTE: echo -e might vary based on container being run in, it may just need echo
  let config_writer = get(g:, 'vim_code_runner_config_writer', 'echo -e')
  let _store_config = config_writer . " '"
    \ . '[client]'
    \ . '\nuser = ' . '"' . $MYSQLUSER . '"'
    \ . '\npassword = ' . '"' . $MYSQLPASSWORD . '"'
    \ . "' > " . tmp_storage . '; '
  let _command_prepend = substitute(_store_config, "'", "'\"'\"'", "g")
  let _command = 'mysql --defaults-extra-file=' . tmp_storage
  if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true')
    let _file_type = get(g:, 'vim_code_runner_csv_type', 'csv')
  else
    let _command = _command . ' --table'
  endif
  if ($MYSQLDATABASE != '')
    let _command = _command . ' --database="' . $MYSQLDATABASE . '"'
  endif
  let _command = _command . ' --execute="' . _preped_text . '"'
  if (!is_in_container)
    let _command = _command . ' --host="' . $MYSQLHOST . '"' . ' --port="' . $MYSQLPORT . '"'
  endif
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunMysqlPostProcessor(args)
  let query_results = a:args['query_results']
  if (get(g:, 'vim_code_runner_sql_as_csv', 'true') == 'true')
    " HACK: if there is a builtin way in mysql cli to create comma delimited instead of tab delimited, then that would be the ideal solution
    let query_results = system("echo '" . query_results . "' | tr ',' ';' | tr '\t' ','")
  endif
  return query_results
endfunction

function! _VCR_RunMongoDb(args)
  let selected_text = a:args['selected_text']
  let is_in_container = a:args['is_in_container']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = 'mongosh --quiet'
  if ($MONGODBUSER != '')
    let _command = _command . " -u '" . $MONGODBUSER . "'"
  endif
  if ($MONGODBPASSWORD != '')
    let _command = _command . " -p '" . $MONGODBPASSWORD . "'"
  endif
  let _command = _command . " --eval '" . _preped_text . "'"
  if (!is_in_container)
    let _command = _command . " --host '" . $MONGODBHOST . "'" . " --port '" . $MONGODBPORT . "'"
  endif
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunCassandra(args)
  let selected_text = a:args['selected_text']
  let is_in_container = a:args['is_in_container']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = 'cqlsh'
  if ($CASSANDRA_USER != '')
    let _command = _command . " -u '" . $CASSANDRA_USER . "'"
  endif
  if ($CASSANDRA_PASSWORD != '')
    let _command = _command . " -p '" . $CASSANDRA_PASSWORD . "'"
  endif
  let _command = _command . " --execute '" . _preped_text . "'"
  if (!is_in_container)
    let _command = _command . " '" . $CASSANDRA_HOST . "'" . " '" . $CASSANDRA_PORT . "'"
  endif
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunNeo4j(args)
  let selected_text = a:args['selected_text']
  let is_in_container = a:args['is_in_container']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _command = 'cypher-shell'
  if ($NEO4J_USER != '')
    let _command = _command . " -u '" . $NEO4J_USER . "'"
  endif
  if ($NEO4J_PASSWORD != '')
    let _command = _command . " -p '" . $NEO4J_PASSWORD . "'"
  endif
  if (!is_in_container)
    let _command = _command . " -h '" . $NEO4J_HOST . "'"
  endif
  let _command = _command . " '" . _preped_text . "'"
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunRedis(args)
  let selected_text = a:args['selected_text']
  let is_in_container = a:args['is_in_container']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let tmp_storage = "/tmp/vim_code_runner_redis_query"
  let tmp_reply = "/tmp/vim_code_runner_redis_reply"
  let _store_query = 'echo "' . _preped_text . '" > ' . tmp_storage . '; '
  let _command_prepend = _store_query
  let _command = 'cat ' . tmp_storage . ' | ' . 'redis-cli '
  if (!is_in_container)
    let _command = _command . "-h '" . $REDISHOST . "'" . " -p '" . $REDISPORT . "' "
  endif
  let _command = _command
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunPhp(args)
  let selected_text = a:args['selected_text']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
  let _php_open_tag_pattern = "^\n*\s*<\?php\s*"
  let _php_close_tag_pattern = "\s*?>\n*\s*"
  if match(_preped_text, _php_open_tag_pattern) >= 0
    let _preped_text = substitute(_preped_text, _php_open_tag_pattern, "", "")
    let _preped_text = substitute(_preped_text, _php_close_tag_pattern, "", "")
  endif
  let _command = "php -r '" . _preped_text . "'"
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunSh(args)
  let selected_text = a:args['selected_text']
  let is_in_container = a:args['is_in_container']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let does_begin_with_shebang = match(raw_text, '^#!')
  if (does_begin_with_shebang >= 0)
    let shebang_lang_pattern = '^#![^\n]*[/ ]\v(\w+)(.*)'
    let shebang_lang = substitute(raw_text, shebang_lang_pattern, '\=submatch(1)', '')
    if (shebang_lang != '')
      let selected_text_override = substitute(raw_text, shebang_lang_pattern, '\=submatch(2)', '')
      if (selected_text_override != '')
        if (g:vim_code_runner_debug == 'true')
          echo g:vim_code_runner_debug_label "trying to run with shebang_lang: " shebang_lang
        endif
        let file_ext = ''
        let run_type = shebang_lang
        let markdown_tag = ''
        let case_values = _VCR_RunCases(file_ext, run_type, markdown_tag, selected_text_override, is_in_container)
        return case_values
      endif
    endif
  else
    let _command_prepend = ''
    let _file_type = g:vim_default_file_type
    let _preped_text = substitute(raw_text, "'", "'\"'\"'", "g")
    let _command = "sh -c '" . _preped_text . "'"
    let split_style = g:_vcr_split_styles_bottom
    return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
  endif
endfunction

function! _VCR_RunBat(args)
  let selected_text = a:args['selected_text']
  let run_path = a:args['runner_config']['run_types'][0]
  let raw_text = selected_text
  let _command_prepend = ''
  let _file_type = g:vim_default_file_type
  let _preped_text = raw_text
  let _command = 'cmd /C "' . _preped_text . '"'
  let split_style = g:_vcr_split_styles_bottom
  return {'command': l:_command, 'split_style': l:split_style, 'command_prepend': l:_command_prepend, 'file_type': l:_file_type, 'run_path': l:run_path}
endfunction

function! _VCR_RunZsh(args)
  let root_command = "zsh -c"
  let a:args['root_command'] = root_command
  return _VCR_RunBasic(a:args)
endfunction

function! _VCR_RunBash(args)
  let root_command = "bash -c"
  let a:args['root_command'] = root_command
  return _VCR_RunBasic(a:args)
endfunction

function! _VCR_RunPython(args)
  let root_command = "python -c"
  let a:args['root_command'] = root_command
  return _VCR_RunBasic(a:args)
endfunction

function! _VCR_RunJavascript(args)
  let root_command = "node -e"
  let a:args['root_command'] = root_command
  return _VCR_RunBasic(a:args)
endfunction

function! _VCR_RunTypescript(args)
  let root_command = "ts-node -e"
  let a:args['root_command'] = root_command
  return _VCR_RunBasic(a:args)
endfunction

function! _VCR_RunRuby(args)
  let root_command = "ruby -e"
  let a:args['root_command'] = root_command
  return _VCR_RunBasic(a:args)
endfunction

function! _VCR_RunPerl(args)
  let root_command = "perl -e"
  let a:args['root_command'] = root_command
  return _VCR_RunBasic(a:args)
endfunction

function! _VCR_RunPowershell(args)
  let root_command = "pwsh -command"
  let a:args['root_command'] = root_command
  return _VCR_RunBasic(a:args)
endfunction

function _VCR_IsLabelMemOf(actual_label, expected_labels)
  for expected_label in a:expected_labels
    if (a:actual_label == expected_label)
      return 1
    endif
  endfor
  return 0
endfunction

function _VCR_IsRunner(runner_config, run_type, file_ext, markdown_tag, filetype)
  return _VCR_IsLabelMemOf(a:run_type, a:runner_config['run_types'])
    \ || (
    \  a:run_type == ''
    \  && (
    \    _VCR_IsLabelMemOf(a:file_ext, a:runner_config['file_extensions'])
    \    || _VCR_IsLabelMemOf(a:markdown_tag, a:runner_config['markdown_tags'])
    \    || _VCR_IsLabelMemOf(&filetype, a:runner_config['file_types']))
    \ )
endfunction

function _VCR_RunCases(file_ext, run_type, markdown_tag, selected_text, is_in_container)
  let case_values = {}
  for runner_config in g:vim_code_runner_runner_configs
    if (_VCR_IsRunner(runner_config, a:run_type, a:file_ext, a:markdown_tag, ''))
      let FuncRef = function(runner_config['command_builder_fn_name'])
      let func_input = {
        \'selected_text': a:selected_text,
        \'is_in_container': a:is_in_container,
        \'runner_config': runner_config
      \}
      let case_values = FuncRef(func_input)
      break
    endif
  endfor
  let case_values['runner_config'] = runner_config
  return case_values
endfunction

function _VCR_ResizeList(list, new_size)
  let new_list = a:list
  let size_diff = len(a:list) - a:new_size
  if (size_diff > 0)
    let slice_index = size_diff * -1 - 1
    let new_list = a:list[:slice_index]
  endif
  return new_list
endfunction

function VimCodeRunnerRun(...)
  let selected_text = get(a:, 1, '')
  let run_type = get(a:, 2, '')
  let debug = get(a:, 3, 'false')
  let g:vim_code_runner_debug = debug
  let _default_file_type = "text"
  if (g:vim_code_runner_debug == 'true')
    echo g:vim_code_runner_debug_label "selected_text: " selected_text
  endif
  if (trim(selected_text) == '')
    echohl WarningMsg
    echo g:_vcr_no_selected_text_warning
    echohl None
    return
  endif
  let is_in_container = !empty(get(g:, 'vim_code_runner_container_name', "")) && trim(g:vim_code_runner_container_name) != ''
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
  let case_values = _VCR_RunCases(file_ext, run_type, markdown_tag, selected_text, is_in_container)
  let _command = get(case_values, 'command', '')
  let split_style = get(case_values, 'split_style', '')
  let _command_prepend = get(case_values, 'command_prepend', '')
  let _file_type = get(case_values, 'file_type', _default_file_type)
  let run_path = get(case_values, 'run_path', '')
  let runner_config = get(case_values, 'runner_config', '')
  if (run_path == '')
    echohl WarningMsg
    echo "No matching run_path!"
    echohl None
    return
  endif
  let _base_command = _command
  if (!empty(get(l:, '_command_prepend', '')))
    let _base_command = "sh -c '"
          \ . _command_prepend
          \ . _base_command
          \ . "'"
  endif
  if (is_in_container)
    let vim_code_runner_container_type = get(g:, 'vim_code_runner_container_type', 'docker')
    let container_cli = "docker"
    if (vim_code_runner_container_type == "k8s")
      let container_cli = "kubectl"
    endif
    let _container_command = container_cli . " exec \"" . g:vim_code_runner_container_name . '" '
    if (vim_code_runner_container_type == "k8s")
      let _container_command = _container_command . "-- "
    endif
    let _command = _container_command . _base_command
  else
    let _command = _base_command
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
    if (get(l:runner_config, 'post_processor_fn_name', '') != '')
      let PostExecuteResultCleaningFnRef = function(runner_config['post_processor_fn_name'])
      let post_processor_input = {'query_results': query_results}
      let query_results = PostExecuteResultCleaningFnRef(post_processor_input)
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
    if (split_style == g:_vcr_split_styles_bottom)
      let og_split_below = &splitbelow
      set splitbelow
      horizontal belowright VimCodeRunnerScratch
      put =query_results
      let &filetype = _file_type
      execute "normal! ggdd"
      let &splitbelow = og_split_below
    else
      put =query_results
    endif
  else
    echo g:vim_code_runner_debug_label "run_path: " run_path
    echo g:vim_code_runner_debug_label "vim_code_runner_container_type: " get(g:, 'vim_code_runner_container_type', '')
    echo g:vim_code_runner_debug_label "vim_code_runner_container_name: " get(g:, 'vim_code_runner_container_name', '')
    echo g:vim_code_runner_debug_label "_command: " _command
    echo g:vim_code_runner_debug_label "_command_prepend: " _command_prepend
    echo g:vim_code_runner_debug_label "split_style: " split_style
    echo g:vim_code_runner_debug_label "selected runners runner_config: " runner_config
  endif
endfunction
