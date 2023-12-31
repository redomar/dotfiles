# Pre load

set -x CONFIG "$HOME/.config"

#
# Abbreviations
#
#abbr -a a "xdcc-dl"
abbr -a ari "aria2c"
abbr -a c "code ."
abbr -a conf "$CONFIG/fish"
abbr -a cl "clear"
#abbr -a cf "sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
#abbr -a e "ssh eagle"
#abbr -a fl "flutter"
abbr -a gcm "git commit -m"
abbr -a lad "la -d */ | sed 's/\/\//\//' | awk '{print \"\033[34m\" \$NF}'"
abbr -a i "iina ."
abbr -a lll "tree -dL 1"
abbr -a nst "npm run start"
abbr -a ndev "npm run dev"
abbr -a nn "nvim"
#abbr -a nvmu "nvm use"
#abbr -a nodem "./node_modules/.bin/nodemon"
abbr -a o "open ."
#abbr -a p "python"
#abbr -a py "pyenv activate"
abbr -a v "vim"
#abbr -a vimrc "vim ~/.vimrc"
abbr -a vif "nvim $CONFIG/fish/config.fish && source $CONFIG/fish/config.fish"
abbr -a vic "nvim ~/.config/nvim/lua/redomar"

#
# Aliases
#
alias config="/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias m="~/Documents/mpv.app/Contents/MacOS/mpv"
alias psgrep="ps aux | grep"
alias vimode="fish_vi_key_bindings"
alias vinorm="fish_default_key_bindings"

#
# Environmental Variables
#
set -x EDITOR "/opt/homebrew/bin/nvim"
#set -x DOTNET_ROOT "$HOME/.dotnet"
#set -g fish_user_paths "$HOME/.dotnet" $fish_user_paths

#set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
#set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths
#set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths

## Gnu Utils and Core Utils
### set PATH "/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#set -g fish_user_paths "/usr/local/opt/grep/libexec/gnubin" $fish_user_paths
#set -g fish_user_paths "/usr/local/opt/gnu-sed/libexec/gnubin" $fish_user_paths

## Compilers
#set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
#set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"
#set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl@1.1/lib/pkgconfig"
#set -gx LDFLAGS "-L/usr/local/opt/readline/lib $LDFLAGS"
#set -gx CPPFLAGS "-I/usr/local/opt/readline/include $CPPFLAGS"
#set -gx PKG_CONFIG_PATH "/usr/local/opt/readline/lib/pkgconfig $PKG_CONFIG_PATH"
#set -gx LDFLAGS "-L/usr/local/opt/sqlite/lib $LDFLAGS"
#set -gx CPPFLAGS "-I/usr/local/opt/sqlite/include $CPPFLAGS"
#set -gx PKG_CONFIG_PATH "/usr/local/opt/sqlite/lib/pkgconfig $PKG_CONFIG_PATH"
#set -gx LDFLAGS "-L/usr/local/opt/zlib/lib $LDFLAGS"
#set -gx CPPFLAGS "-I/usr/local/opt/zlib/include $CPPFLAGS"
#set -gx PKG_CONFIG_PATH "/usr/local/opt/zlib/lib/pkgconfig $PKG_CONFIG_PATH"
set -x PATH $HOME/.local/share/nvim/mason/bin $PATH
#
# Interacrive Funcrions
#
if status is-interactive
  #Pyenv
  set -g fish_user_paths $PYENV_ROOT/bin $fish_user_paths
  status is-login; and pyenv init --path | source
  pyenv init - | source
end

#
# Custom Functions
#
function sgit -d "Use ssh to git clone"
    echo $argv | sed "s/https:\/\//git@/" | sed "s/\$/\.git/" | sed "s/com\//com:/" | read -l link
    echo 'Cloning' $link
    git clone $link
end

# bass source ~/.nvm/nvm.sh --no-use ';' nvm use default > /dev/null 2>&1
source ~/.config/fish/functions/ez_aliases.fish


# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
