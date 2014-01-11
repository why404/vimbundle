vimbundle
=========

My `.vim` directory; configuration for the [Vim text editor](http://en.wikipedia.org/wiki/Vim_%28text_editor%29).


## Installation

### On Mac/Linux:

	git clone https://github.com/why404/vimbundle.git ~/.vim
    cd ~/.vim
    git submodule init
    git submodule update
    ln -nsf ~/.vim/vimrc ~/.vimrc

### On Windows:

	git clone https://github.com/why404/vimbundle.git %HOME%\vimfiles
    cd %HOME%\vimfiles
    git submodule init
    git submodule update
    copy vimrc ..\_vimrc

### Use Vundle to install plugins

Launch `vim`, run `:BundleInstall` 
(or `vim +BundleInstall +qall` for CLI lovers)

*Windows users*: see [Vundle for Windows](https://github.com/gmarik/vundle/wiki/Vundle-for-Windows)

Installation requires [Git] and triggers [`git clone`](http://gitref.org/creating/#clone) for each configured repo to `~/.vim/bundle/`.
