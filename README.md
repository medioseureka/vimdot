# Best web IDE like vim's dot file

> This steps are for unix system if you want to use it in another environment use each plugin's site

## how to install?
  - clone the repo
  - cd vimdot
  - cp vimrc ~/.vimrc
  - cp {php.vim,python.vim} ~/.vim/ftplugin
  - `curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
  - Enter in vim and install all plugins :PlugInstall
  - Install all coc servers `CocInstall coc-tsserver coc-json coc-html coc-css coc-python coc-phpls coc-angular coc-eslint coc-vetur` 
  - cd .. && rm -rf vimdot
  - Ready to use