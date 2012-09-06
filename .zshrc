# .zshrc
# lang
export LANG=ja_JP.UTF-8
#export LANG=C
bindkey -e

# prompt
setopt prompt_subst
PROMPT='${HOST%%.*}:${USER}%(!.#.$) '
RPROMPT='[%~]'
case ${TERM} in
	xterm-256color)
		precmd(){
			echo -ne "\033]0;${HOST%%.*}\007"
		}
#		preexec () {
#			1="$1 "
#			echo -ne "\ek${${(s: :)1}[0]}\e\\"
#		}
		;;
	xterm*)
		precmd(){
#			echo -ne "\033]0;${USER}@${HOST%%.*}: ${PWD}\007"
			echo -ne "\033]0;${HOST%%.*}\007"
		}
		#export GNUTERM=x11
		;;
	ansi*)
		precmd(){
			echo -ne "\033]0;${HOST%%.*}\007"
		}
		;;
	rxvt*)
		precmd(){
			echo -ne "\033]0;${HOST%%.*}\007"
		}
		;;
	screen*)
		precmd(){
			echo -ne "\033]0;${HOST%%.*}\007"
		}
		chpwd () { echo -n "_`dirs`\\" }
		preexec () {
			#1="$1 "
			#echo -ne "\ek${${(s: :)1}[0]}\e\\"
			emulate -L zsh
			local -a cmd; cmd=(${(z)2})
			case $cmd[1] in
				fg) 
					if (( $#cmd == 1)); then
						cmd=(builtin jobs -l %+)
					else
						cmd=(builtin jobs -l $cmd[2])
					fi
					;;
				%*)
					cmd=(builtin jobs -l $cmd[1])
					;;
				cd|bash|zsh)
					if (( $#cmd == 2)); then
						cmd[1]=$cmd[2]
					fi
					;&
				*)
					echo -n "k$cmd[1]:t\\"
					return
					;;
			esac
			local -A jt; jt=(${(kv)jobtexts})
			$cmd >> (read num rest
				cmd=(${(z)${(e):-\$jt$num}})
				echo -n "k$cmd[1]:t\\") 2 >>/dev/null
		}
		chpwd
		;;
esac

function tenkai() {
	for i in $@
	do
		if [ -e $i ]
		then
			case $i in
			*.tar.gz|*.tgz)
				tar xvzf $i
				;;
			*.gz)
				gunzip $i
				;;
			*.tar.bz2|*.tbz2)
				tar xvjf $i
				;;
			*.bz2)
				bunzip $i
				;;
			*.tar)
				tar xvf $i
				;;
			*.zip)
				unzip $i
				;;
			*.lzh)
				lha x $i
				;;
			*.Z)
				uncompress $i
				;;
			*.7z)
				7z e $i
				;;
			esac
		else
			echo "$i: No such file or directory"
		fi
	done
}

#function trash() {
#	for i in $@
#	do
#		if [ -e $i ]
#		then
#			ii=$i
#			declare -i num=1
#			while [ -e ~/.Trash/$ii ]
#			do
#				ii="$i"-"$num"
#				num=$num+1
#			done
#			mv -i $i ~/.Trash/$ii
#		else
#			echo "$i: No such file or directory"
#		fi
#	done
#}
function trash() {
	DATES=`date "+%y%m%d-%H%M%S"`
	mkdir ~/.Trash/$DATES
	for i in $@; do
		if [ -e $i ]; then
			mv $i ~/.Trash/$DATES/
		else
			echo "trash: $i: no input file"
		fi
	done
}

#function cdup() {
#	echo
#	cd ..
#	zle reset-prompt
#}
#zle -N cdup
#bindkey '\^' cdup

#fpath=(/usr/local/share/zsh/functions $fpath)

# completion
autoload -U compinit
compinit
zstyle ':completion:*' list-colors  'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

compdef _tex platex
compdef _tex tex2pdf
compdef _tex tex2eps
compdef _pdf acroread


# prediction
#autoload predict-on
#predict-on

# shell options
setopt auto_menu correct auto_name_dirs
setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
setopt extended_glob list_types no_beep always_last_prompt
setopt cdable_vars sh_word_split auto_param_keys
setopt noautoremoveslash

# path
#path=(/opt/screen/bin /sw/bin /usr/local/bin /usr/bin /bin /usr/X11R6/bin /usr/sbin /sbin)
#path=(/opt/local/lib/gromacs/bin /opt/NAMD /opt/screen/bin /opt/local/bin /opt/local/sbin /usr/local/bin /usr/bin /bin /usr/X11R6/bin /usr/sbin /sbin)
#path=(/usr/texbin /usr/local/bin /opt/local/bin /usr/bin /bin /usr/X11R6/bin /usr/sbin /sbin)
path=(/usr/texbin /opt/local/bin /opt/local/sbin /opt/X11/bin /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin)
MANPATH=`/usr/bin/manpath`:/Library/TeX/Distributions/.DefaultTeX/Contents/Man/
#MANPATH=`/usr/bin/manpath`:/opt/screen/share/man
#manpath=(/opt/screen/share/man /usr/texbin/man /opt/local/share/man/ja /opt/local/share/man /usr/local/share/man /usr/share/man /usr/X11R6/share/man /usr/X11/man)

# cd
setopt auto_cd
setopt auto_pushd # cd -[tab]
setopt list_packed # cd [tab]
cdpath=($HOME)

# history
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=100000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt share_history
setopt extended_history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end 
bindkey "^N" history-beginning-search-forward-end

# alias
setopt complete_aliases
#export LSCOLORS=exfxcxdxbxegedabagacad
#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#alias ls='ls -vFG --color'
alias ls='/bin/ls -vFG'
#alias ls='gls -vFG --color'
#alias ls='gls -vFG --color --show-control-char'
#alias ls='ls -vFG --color --show-control-char'
alias la='ls -A'
alias ll='ls -l'
alias lv='lv -z -Ia -Ou8'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
#alias trash='rmtrash'
alias mi='open -a mi'
alias xcode='open -a xcode'
alias acroread='open -a /Applications/Adobe\ Acrobat\ X\ Pro/Adobe\ Acrobat\ Pro.app'
#alias screen='/opt/screen/bin/screen -U'
alias vmd='/Applications/VMD\ 1.9.1.app/Contents/MacOS/startup.command'
alias vi='vim'
alias tail='gtail'
alias head='ghead'
alias cat='gcat'
alias tar='gnutar'
alias sed='gsed'
alias ln='gln'

alias -s txt='vim'
alias -s tex='vim'
alias -s f='vim'
alias -s c='vim'
alias -s java='vim'
alias -s pl='vim'
alias -s html='vim'
alias -s pdf='open'
alias -s eps='open'
alias -s gz='tenkai'
alias -s bz2='tenkai'
alias -s zip='tenkai'
alias -s lzh='tenkai'
alias -s tar='tenkai'
alias -s tgz='tenkai'
alias -s tbz2='tenkai'
alias -s Z='tenkai'
alias -s 7z='tenkai'

#alias -g L='| lv'
alias -g L='| less'
alias -g G='| grep -i'
alias -g H='| head'
alias -g T='| tail'

export EDITOR=vim
export PAGER=less
export BLOCKSIZE=k

#export LDFLAGS=-L/usr/local/Cellar/lapack/3.4.0/lib
#export CPPFLAGS=-I/usr/local/Cellar/lapack/3.4.0/include
 
source /opt/intel/bin/compilervars.sh intel64

export PATH=/opt/mpich/bin:$PATH
export LD_LIBRARY_PATH=/opt/mpich/lib:$LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=/opt/mpich/lib:$DYLD_LIBRARY_PATH
export MANPATH=/opt/mpich2/share/man:$MANPATH
