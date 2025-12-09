# ╔═══════════════════════════════════════════════════════════════════════════════╗
# ║                          🐟 Fish Shell Configuration                          ║
# ║                              @redomar's setup                                 ║
# ╚═══════════════════════════════════════════════════════════════════════════════╝
#

# ═════════════════════════════════════════════════════════════════════════════════
# ❯ Core Settings
# ═════════════════════════════════════════════════════════════════════════════════
# Set essential environment variables.
set -x CONFIG "$HOME/.config"
set -x EDITOR "/opt/homebrew/bin/nvim"


# ═════════════════════════════════════════════════════════════════════════════════
# ❯ Abbreviations & Aliases
# ═════════════════════════════════════════════════════════════════════════════════
# Shortcuts for frequently used commands.
# Abbreviations are expanded in the command line, while aliases are not.

# --- Abbreviations ---
abbr -a ari "aria2c"
abbr -a c "code ."
abbr -a conf "nvim $CONFIG/fish/config.fish"
abbr -a cl "clear"
abbr -a gcm "git commit -m"
abbr -a i "iina ."
abbr -a lad "la -d */ | sed 's/\/\//\//' | awk '{print \"\033[34m\" \$NF}'"
abbr -a lll "tree -dL 1"
abbr -a ndev "npm run dev"
abbr -a nn "nvim"
abbr -a nst "npm run start"
abbr -a o "open ."
abbr -a v "vim"
abbr -a vic "nvim ~/.config/nvim/lua/redomar"
abbr -a vif "nvim $CONFIG/fish/config.fish && source $CONFIG/fish/config.fish"

# --- Aliases ---
# Alias for managing dotfiles with a bare git repository.
alias config="/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias m="~/Documents/mpv.app/Contents/MacOS/mpv"
alias psgrep="ps aux | grep"

# Vi mode key bindings
alias vimode="fish_vi_key_bindings"
alias vinorm="fish_default_key_bindings"

# Personal CLI tools
alias claude="/Users/Mohamed/.claude/local/claude"


# ═════════════════════════════════════════════════════════════════════════════════
# ❯ Environment & Path Management
# ═════════════════════════════════════════════════════════════════════════════════
# Add binaries and tools to the PATH.
# `fish_add_path` is used to prevent duplicate entries.

fish_add_path "$HOME/.local/share/nvim/mason/bin" # Neovim Mason
fish_add_path "$HOME/.bun/bin"                    # Bun package manager
fish_add_path "/Users/Mohamed/Library/pnpm"       # pnpm package manager


# ═════════════════════════════════════════════════════════════════════════════════
# ❯ Tool & Plugin Initialization
# ═════════════════════════════════════════════════════════════════════════════════
# These commands need to run to configure specific shell tools.

# --- Zoxide ---
# A smarter `cd` command.
zoxide init fish | source

# --- Pyenv & Interactive Shell ---
# This block runs only for interactive shells to avoid issues in scripts.
if status is-interactive
    # Initializes pyenv for Python version management.
    command -v pyenv >/dev/null; and pyenv init --path | source
    command -v pyenv >/dev/null; and pyenv init - | source
end


# ═════════════════════════════════════════════════════════════════════════════════
# ❯ Custom Functions
# ═════════════════════════════════════════════════════════════════════════════════

# Clones a GitHub repository using its SSH URL.
# Usage: sgit https://github.com/user/repo
function sgit --description "Clone a GitHub repo via SSH"
    # Extract user/repo and rewrite the URL to the git@... format.
    set -l ssh_url (echo $argv[1] | sed -E 's|https://github.com/([^/]+/[^/]+).*|git@github.com:\1.git|')
    if test -n "$ssh_url"
        echo "Cloning via SSH: $ssh_url"
        git clone "$ssh_url"
    else
        echo "Invalid GitHub URL provided."
    end
end

# Clones a GitHub repository using a custom SSH host 'github-origin'.
# Usage: sgito https://github.com/user/repo
function sgito --description "Clone a GitHub repo via SSH using a custom remote"
    # Extract user/repo and rewrite the URL to use the 'github-origin' host.
    set -l ssh_url (echo $argv[1] | sed -E 's|https://github.com/([^/]+/[^/]+).*|git@github-origin:\1.git|')
    if test -n "$ssh_url"
        echo "Cloning via SSH (origin): $ssh_url"
        git clone "$ssh_url"
    else
        echo "Invalid GitHub URL provided."
    end
end

# Collects Github Container Registry Token from 1Password and saves it on Environment.
function set_ghcr_token
    # Check if the GHCR_TOKEN is already set to avoid re-fetching
    if test -z "$GHCR_TOKEN"
        # Replace "GitHub Container Registry Token" with the exact name of your 1Password item
        # Replace "token" with the exact name of the field where you stored the token
        set -gx GHCR_TOKEN (op read "op://Private/Github Container Registry Token/credential")

        if test $status -ne 0
            echo "Failed to retrieve GHCR_TOKEN from 1Password. Is 'op' signed in?" >&2
            set -e GHCR_TOKEN # Unset if retrieval failed
        else
            echo "GHCR_TOKEN loaded from 1Password."
        end
    else
        echo "GHCR_TOKEN already set."
    end
end

# --- Sourcing Other Functions ---
# Load custom alias functions from an external file.
source ~/.config/fish/functions/ez_aliases.fish
#set_ghcr_token

# ═════════════════════════════════════════════════════════════════════════════════
# ❯ Reference Section
# ═════════════════════════════════════════════════════════════════════════════════
# This section contains previously used or commented-out settings for
# future reference. They are not active.

#
# --- Old Abbreviations ---
#abbr -a a "xdcc-dl"
#abbr -a cf "sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache"
#abbr -a e "ssh eagle"
#abbr -a fl "flutter"
#abbr -a nvmu "nvm use"
#abbr -a nodem "./node_modules/.bin/nodemon"
#abbr -a p "python"
#abbr -a py "pyenv activate"
#abbr -a vimrc "vim ~/.vimrc"

#
# --- Old Environmental Variables & Paths ---
#set -x DOTNET_ROOT "$HOME/.dotnet"
#set -g fish_user_paths "$HOME/.dotnet" $fish_user_paths
#set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
#set -g fish_user_paths "/usr/local/opt/sqlite/bin" $fish_user_paths
#set -g fish_user_paths "/usr/local/opt/curl/bin" $fish_user_paths

#
# --- Old Gnu & Core Utils ---
#set PATH "/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#set -g fish_user_paths "/usr/local/opt/grep/libexec/gnubin" $fish_user_paths
#set -g fish_user_paths "/usr/local/opt/gnu-sed/libexec/gnubin" $fish_user_paths

#
# --- Old Compiler Flags (for building from source) ---
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

#
# --- Old NVM loader ---
# bass source ~/.nvm/nvm.sh --no-use ';' nvm use default > /dev/null 2>&1

# pnpm
set -gx PNPM_HOME "/Users/Mohamed/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
