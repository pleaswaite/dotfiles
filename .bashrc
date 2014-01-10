#.bashrc...

#basic info about the system
uptime

#I'm lazy...and like to use terminals as calculators
calc () {
echo "scale=4; $1" | bc
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
HISTSIZE=5000

#append history if terminal exits
shopt -s histappend

#Custom variables
export PATH=/Users/swaite/.rvm/gems/ruby-1.9.3-p392/bin:/Users/swaite/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/swaite/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/swaite/.rvm/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/opt/local/bin:/opt/local/sbin:/Users/swaite/bin:/usr/bin
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:$HOME/.rvm/bin:~/bin 
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

#make rvm work...dammit
source ~/.rvm/scripts/rvm
