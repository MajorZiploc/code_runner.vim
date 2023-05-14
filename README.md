# vim_code_runner

Run selected chunks of code. Can run locally or within docker containers

## supported runners

- postgresql (psql) - must be files saved as *.pgsql

The following are based on filetype
- python
- javascript
- typescript
- perl
- ruby

## runner options

### specific runner options

#### psql

## recommended keybindings

The t register is used to get the selected_text and use in the Run command

```vim
" runs the selected_text with the determined run_type
vmap <leader>5 "ty:call VimCodeRunnerRun()<CR>
" dry run / debug what VimCodeRunnerRun() will do in a real run
vmap <leader>4 "ty:call VimCodeRunnerRun('', 'true')<CR>
```

