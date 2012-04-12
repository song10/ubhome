set nocompatible
source ~/wrk/bin/murphy.vim
source ~/wrk/bin/cscope_maps.vim
syntax on

set hls
set incsearch
set ruler
"set et
set tags=./tags
set nobackup
"set mouse=a

map <F2> <ESC>:%!xxd<CR>
map <F3> <ESC>:%!xxd -r<CR>
map <F4> <ESC>:set paste<CR>
map <F5> <ESC>:set nopaste<CR>

map M :%s///g

