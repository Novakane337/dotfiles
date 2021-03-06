# $HOME/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ___OPTIONS___
# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null
# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# Append to the history file, don't overwrite it
shopt -s histappend
# Save multi-line commands as one command
shopt -s cmdhist
# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# ___ENV___
export HISTFILE="$HOME"/.cache/bash/bash_history
# User local scripts
[[ -d "$HOME"/.local/bin ]] && path=("$HOME"/.local/{bin,bin/colors} $path)
systemctl --user import-environment PATH

export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export PARALLEL_HOME="$XDG_CACHE_HOME"/parallel
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

# Npm
if command -v npm >/dev/null 2>&1; then
  export PATH="$XDG_DATA_HOME"/npm/bin:$PATH
  export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
fi

# Rust
if [[ -d "$XDG_DATA_HOME"/rustup ]] && [[ -d "$XDG_DATA_HOME"/cargo ]]; then
  export RUSTUP_HOME="$HOME"/.local/share/rustup
  export CARGO_HOME="$HOME"/.local/share/cargo
  export PATH="$HOME"/.local/share/cargo/bin:$PATH
fi

# BSPWM
if [[ -d "$XDG_CONFIG_HOME"/bspwm ]]; then
  export PANEL_FIFO="/tmp/panel-fifo"
  path=("$HOME"/.config/bspwm/{scripts,panel} $path)
fi

# NNN
if command -v nnn >/dev/null 2>&1; then
  export NNN_COLORS='2314'
  export NNN_TRASH=1
  export NNN_USE_EDITOR=1
  export NNN_RESTRICT_NAV_OPEN=0
  export NNN_RESTRICT_0B=1
  export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
  export NNN_COPIER="$XDG_CONFIG_HOME"/nnn/copier
  export NNN_BMS='c:~/.config;n:~/.config/nvim;z:~/.config/zsh;a:~/.config/awesome;i:~/img;s:~/dev;d:~/doc;l:~/.local/share'
  export NNN_PLUG='f:browse_img_full;i:browse_img;o:open;s:fuzzy;c:_chmod 774 $nnn*;e:exec'
fi
# RIPGREP
if command -v rg >/dev/null 2>&1; then
  export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/rc
fi

# EXA
if command -v exa >/dev/null 2>&1; then
  export EXA_COLORS="lp=34:da=37:uu=33:sn=35:sb=35"
fi


# ___ALIAS___
# Files
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nvim PKGBUILD'
alias fixit='sudo rm -f /var/lib/pacman/db.lck'
alias cmx='chmod 774'

# ___PROMPT___
function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "$RETVAL"
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

export PS1="\[\e[33m\]\w\[\e[m\] \`parse_git_branch\` \[\e[31m\]\`nonzero_return\`\[\e[m\] "

