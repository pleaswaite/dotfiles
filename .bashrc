#.bashrc...

uptime

calc () {
echo "scale=4; $1" | bc
}

#Custom
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:$HOME/.rvm/bin 
export EDITOR=vim

#fix stupid scripts that require cleartext pw in config:
#note, will still echo your password...
alias pwprompt='read -s -p "Password: " ; echo >&2 ; echo ${REPLY}'
