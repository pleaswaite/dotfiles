#.bashrc...

#basic info about the system
uptime

#I'm lazy...and like to use terminals as calculators
calc () {
echo "scale=4; $1" | bc
}

#moar bash_history
HISTSIZE=5000

#append history if terminal exits
shopt -s histappend

#Custom variables
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

#make rvm work...dammit
source ~/.rvm/scripts/rvm
