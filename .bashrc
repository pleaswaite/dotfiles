#.bashrc...

#basic info about the system
uptime

#I'm lazy...and like to use terminals as calculators
calc () {
echo "scale=4; $1" | bc
}

#Custom variables
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:$HOME/.rvm/bin:~/bin 
export EDITOR=vim

#Custom Alias'

#fix stupid scripts that require cleartext pw in config:
#note, will still echo your password...
alias pwprompt='read -s -p "Password: " ; echo >&2 ; echo ${REPLY}'
alias vc=vimcat #vimcat == colourized cat output!
