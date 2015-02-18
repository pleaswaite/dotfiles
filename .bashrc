#.bashrc...

#gimme the quote, yo
fortune taglines
#basic info about the system
uptime


#I'm lazy...and like to use terminals as calculators
calc () {
echo "scale=4; $1" | bc
}

sshuntil () {
until [ `ssh $1` ]; do
	ssh $1
done
}
#calc () {
#	export CALCSTRING=""
#	for x in $*; do
#		if [$x ==  '*' ] 
#			then 
#			$x="\*"
#		fi
#		CALCSTRING="$CALCSTRING $x"
#	done
#	echo -- "scale=4; $CALCSTRING" | bc
#}

dalc () {
export CALCSTRING=""
for x in $*; do 
CALCSTRING="$CALCSTRING $x"
done
echo "4 k $CALCSTRING p" | dc
}


#this is a stupid thing trying to allow spaces in my calc input
calcMEAT () {
(
set -x
echo "scale=4; $*" | bc
exit 0
)
}

#moar bash_history
HISTSIZE=1000000
#append history if terminal exits
shopt -s histappend
#store history immediately
PROMPT_COMMAND='history -a'
#compact multiline commands
shopt -s cmdhist
#ignore dupes and whitespace in history
HISTCONTROL=ignoreboth
#ignore crap we don't really care about
HISTIGNORE='ls:bg:fg:history:df'

#Custom variables
export PATH=/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/opt/local/sbin:/Users/swaite/bin:/usr/bin:/opt/local/bin:/opt/local/sbin:~/bin:~/.aws/bin 
export EDITOR=vim

#Custom Alias'

#fix stupid scripts that require cleartext pw in config:
#note, will still echo your password...
alias pwprompt='read -s -p "Password: " ; echo >&2 ; echo ${REPLY}'
alias cat='vimcat' #vimcat == colourized cat output!
alias ls='ls -hG'
alias ll='ls -halG'
alias rm='rm -iv'
alias more='less'
alias sshpasswd='ssh -o PubkeyAuthentication=no'
alias such=git
alias very=git
alias wow='git status' 
alias s4cmd='/usr/bin/python ~/bin/s4cmd/s4cmd.py'
alias nvpy='/usr/bin/python ~/bin/nvpy/nvpy/nvpy.py'
alias git-svn='git svn'
alias mine='aws ec2 describe-instances | grep swaite'
#add aws autocompletion
complete -C aws_completer aws
#additional files to source
source ~/.bash/ec2_source
