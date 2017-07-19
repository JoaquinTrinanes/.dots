# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# be nice
alias please=sudo
alias hosts='sudo $EDITOR /etc/hosts'   # yes I occasionally 127.0.0.1 twitter.com ;)

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi

# List all files colorized in long format
alias l="ls -l ${colorflag}"

# List all files colorized in long format, including dot files
alias la="ls -la ${colorflag}"

# List only directories
alias lsd='ls -l | grep "^d"'

# Always use color output for `ls`
if [[ "$OSTYPE" =~ ^darwin ]]; then
    alias ls="command ls -G"
else
    alias ls="command ls --color"
    export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# `cat` with beautiful colors. requires Pygments installed.
#                              sudo easy_install Pygments
alias c='pygmentize -O style=monokai -f console256 -g'

# IP addresses
#alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Canonical hex dump; some systems have this symlinked
#type -t hd > /dev/null || alias hd="hexdump -C"

# Trim new lines and copy to clipboard
alias trimcopy="tr -d '\n' | pbcopy"

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Shortcuts

# File size
alias fs="stat -f \"%z bytes\""

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done

alias fn_FX_keys="echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode"
alias fn_multimedia_keys="echo 1 | sudo tee /sys/module/hid_apple/parameters/fnmode"
alias o="gio open"
alias s="subl"
alias bye="exit"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    alias open=xdg-open
fi
alias map="xargs -n1"
alias public_ip="curl ifconfig.me"
alias ducks="du -cks *|sort -rn | head"

alias home='cd ~ && clear'

alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias e="$EDITOR"

alias pcat='pygmentize -O bg=dark'
alias doctest='python -m doctest'
alias maild="sudo python -c 'import smtpd, asyncore; smtpd.DebuggingServer((\"127.0.0.1\", 25), None); asyncore.loop()'"
alias ff='find . -iname'
alias debug='cat > /tmp/debug.html&&w3m /tmp/debug.html'
alias t='tmux a||tmux new-s'

alias be="bundle exec"
alias irssi='TERM=screen-256color irssi'

# OS Upgrade aliases
if [[ -e /etc/os-release ]]; then
    case `cat /etc/os-release|grep "ID="|cut -f2 -d"="` in
        "arch")
            alias os-cleanup='sudo pacman -Rcns $(pacman -Qdtq); sudo pacman -Sc --noconfirm; sudo rm /var/lib/systemd/coredump/*; sudo journalctl --vacuum-size=1M; sudo rm -r /var/cache/pacman/pkg/*' # Cleans automatically installed deps
            alias os-upgrade='yaourt -Syyua --noconfirm'
            ;;
        "ubuntu")
            alias os-cleanup='sudo apt-get autoremove; sudo apt-get clean'
            alias os-upgrade='sudo apt-get update; sudo apt-get dist-upgrade'
    esac
fi

if [ -x "$(command -v thefuck)" ]; then
  alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
fi

alias dcu='docker-compose up'
alias dcs='docker-compose stop'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias mux="tmuxinator"
alias pt=papertrail
