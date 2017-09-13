if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" possible folding method
setlocal foldmethod=indent

" this allows gf and :find to work. Fix path to your needs
setlocal suffixesadd=.css

" tab
setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
