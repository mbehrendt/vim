" Acts as :!command but shows the output in a seperate buffer
function! s:ExecuteInShell(command)
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! execute 'resize ' . line('$')
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
    echo 'Shell command ' . command . ' executed.'
    endfunction

    command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

" Opens the regarding Unit Test to a PHP file (needs ZF like folder stucture)
function! OpenPHPUnitTest()
    let file = 'tests/' . substitute(expand('%s'), '.php', '', '') . 'Test.php'
    let cmd  = 'vs ' . file
    execute cmd
endfunction

" Opens scratch markdown file
function! OpenScratchMarkdown()
    let cmd = 'vs ~/Desktop/Scratch.mkd'
    execute cmd
endfunction