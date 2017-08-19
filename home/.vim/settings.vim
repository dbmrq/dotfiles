
runtime! plugin/sensible.vim

" Appearance {{{

syntax enable

set title

set relativenumber
set number

set showcmd

set scrolloff=5
set sidescrolloff=7
set sidescroll=1

set ruler
set laststatus=0
set showmode

au ColorScheme * hi! link StatusLine FoldColumn
au ColorScheme * hi! link StatusLineNC LineNr
au ColorScheme * hi! link VertSplit LineNr
set fillchars=

set stl=
set stl+=%=%t%{&mod?'\ +':''}
set stl+=%{winheight(0)<line('$')?'\ ':''}
set stl+=%{winheight(0)<line('$')?PercentThrough():''}
set stl+=%{&readonly&&&ft!='help'?'\ [RO]':''}
set stl+=%{&ft=='help'?'\ [Help]':''}
set stl+=%{&ff!='unix'?'\ ['.&ff.']':''}
set stl+=%{(&fenc!='utf-8'&&&fenc!='')?'\ ['.&fenc.']':''}
set stl+=\ 

function! PercentThrough()
    return line('.') * 100 / line('$') . '%'
endfunction

set rulerformat=
set rulerformat+=%25(%=%t%{&mod?'\ +':''}%)
set rulerformat+=%{winheight(0)<line('$')?'\ ':''}
set rulerformat+=%{winheight(0)<line('$')?PercentThrough():''}
set rulerformat+=%{&readonly?'\ [RO]':''}
set rulerformat+=%{&ff!='unix'?'\ ['.&ff.']':''}
set rulerformat+=%{(&fenc!='utf-8'&&&fenc!='')?'\ ['.&fenc.']':''}

if $BACKGROUND == 'light'
    set background=light
else
    set background=dark
endif

" }}}

" Wrapping {{{

set wrap
set linebreak
set textwidth=78

au BufRead,BufNewFile */.vim/thesaurus/* set tw=0

if executable("par")
    set formatprg=par\ -w78
endif

if &l:formatoptions =~ "t"
    let &colorcolumn="79,".join(range(101,999),",")
else
    let &colorcolumn="79"
endif

" }}}

" Indentation {{{
set tabstop=4
set shiftwidth=4
set expandtab
set shiftround
" }}}

" Folding {{{
set foldmethod=marker
set foldmarker=\ {{{,\ }}}
" }}}

" Undo {{{

if has('persistent_undo')
    set undofile
    set undolevels=5000
endif

" }}}

" Directories {{{1

set undodir=~/.vim/undo/,.
set backupdir=~/.vim/backup/,.,~/tmp,~/
set directory=~/.vim/swp/,.,~/tmp,/var/tmp,/tmp

" }}}1

" TeX {{{

let g:tex_flavor = "latex"
au BufReadPost,BufNewFile *.bbx,*.cbx,*.lbx,*.cls,*.sty set ft=plaintex

au FileType markdown,text,tex set fo+=12

let g:tex_comment_nospell=1

" }}}

" Misc {{{

set hidden

set backupcopy=yes

set clipboard=unnamed

set ignorecase
set smartcase

set visualbell
set noerrorbells

set shortmess+=c
set shortmess+=A

set updatecount=20
set autowrite

set complete+=kspell

set switchbuf+=useopen,usetab

set nojoinspaces

" change directory to current file's
autocmd BufEnter * if &ft !=? 'tex' | silent! lcd %:p:h

" open file with cursor at last position
autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif

" use ag instead of grep
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

autocmd BufReadPost quickfix set nowrap

" augroup autoquickfix
"     autocmd!
"     autocmd QuickFixCmdPost [^l]* cwindow
"     autocmd QuickFixCmdPost    l* lwindow
" augroup END

" }}}


