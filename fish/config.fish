source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
#
# ~/.config/fish/config.fish

# Aliases - basic
alias reload='source ~/.config/fish/config.fish'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias lt='eza -T -L 4 --icons'
alias l='eza -lah --icons --git'
alias ls='eza --icons'
alias grep='grep --color=auto'
alias patch-vivaldi='~/.config/vivaldi_mods/auto-mod-install.sh'
alias dotfiles='git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME/.config'
# History settings
set -x HISTSIZE 500

# Editor settings
set -x EDITOR nvim
set -x VISUAL nvim
alias spico='sudo pico'
alias snano='sudo nano'
alias vim='nvim'
alias vi='nvim'
alias svi='sudo vi'
alias vis='nvim "+set si"'

# Edit config
alias fishconf='$EDITOR ~/.config/fish/config.fish'
alias niriconf='$EDITOR ~/.config/niri/config.kdl'
alias alaconf='$EDITOR ~/.config/alacritty/alacritty.toml'

# Directory navigation aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Date alias
alias da='date "+%Y-%m-%d %A %T %Z"'

# Modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias yayf="yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S"

# Search files in current folder
alias f="fd . | grep "
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# History search
alias h='history | grep'

# Help
# Define the alias first
alias bathelp='bat --plain --language=help'

# Define the help function
function help
    # "$argv" passes all arguments to the command
    $argv --help 2>&1 | bathelp
end

# Ripgrep check and alias
if command -v rg &>/dev/null
    alias grep='rg'
else
    alias grep='/usr/bin/grep'
end

# Extract function
function extract
    for archive in $argv
        if test -f $archive
            switch $archive
                case '*.tar.bz2'
                    tar xvjf $archive
                case '*.tar.gz'
                    tar xvzf $archive
                case '*.bz2'
                    bunzip2 $archive
                case '*.rar'
                    rar x $archive
                case '*.gz'
                    gunzip $archive
                case '*.tar'
                    tar xvf $archive
                case '*.tbz2'
                    tar xvjf $archive
                case '*.tgz'
                    tar xvzf $archive
                case '*.zip'
                    unzip $archive
                case '*.Z'
                    uncompress $archive
                case '*.7z'
                    7z x $archive
                case '*'
                    echo "don't know how to extract '$archive'..."
            end
        else
            echo "'$archive' is not a valid file!"
        end
    end
end

# Search for text in all files
function ftext
    grep -iIHrn --color=always $argv[1] . | less -r
end

# Copy file with progress bar
function cpp
    rsync -ah --progress $argv
end

# Copy and go to directory
function cpg
    if test -d $argv[2]
        cp $argv[1] $argv[2]; and z $argv[2]
    else
        cp $argv[1] $argv[2]
    end
end

# Move and go to directory
function mvg
    if test -d $argv[2]
        mv $argv[1] $argv[2]; and z $argv[2]
    else
        mv $argv[1] $argv[2]
    end
end

# Create and go to directory
function mkdirg
    mkdir -p $argv[1]
    z $argv[1]
end

# Go up specified number of directories
function up
    set -l limit $argv[1]
    set -l d ""
    for i in (seq 1 $limit)
        set d $d/..
    end
    set d (string replace -r '^/' '' $d)
    if test -z "$d"
        set d ..
    end
    z cd $d
end

# Auto ls after cd
function cd
    if test (count $argv) -gt 0
        builtin cd $argv; and ls
    else
        builtin cd ~; and ls
    end
end

starship init fish | source
zoxide init fish | source
