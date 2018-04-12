#.bashrc...

cat /home/swaite/bin/todayssats

#gimme the quote, yo
#fortune taglines | cowsay
fortune tao | cowsay


#I'm lazy...and like to use terminals as calculators
calc () {
echo "scale=4; $1" | bc
}

sshuntil () {
until [ `ssh $1` ]; do
	sleep 1
done
}

bearing () {
runhaskell /home/swaite/GITREPOS/slog/bearings.hs $1 $2
}

updatekeps () {
wget http://www.amsat.org/amsat/ftp/keps/current/nasabare.txt -O ~/keps/nasabare.txt
wget http://www.amsat.org/amsat/ftp/keps/current/nasa.all -O ~/keps/nasa.txt
wget http://celestrak.com/NORAD/elements/cubesat.txt -O ~/keps/cubesat.txt
wget http://celestrak.com/NORAD/elements/tle-new.txt -O ~/keps/tle-new.txt
wget http://celestrak.com/NORAD/elements/x-comm.txt -O ~/keps/x-comm.txt
wget http://celestrak.com/NORAD/elements/engineering.txt -O ~/keps/engineering.txt

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


###################### Color Git ################
## Define Colors
#COLOR_RED="\033[0;31m"
#COLOR_YELLOW="\033[0;33m"
#COLOR_GREEN="\033[0;32m"
#COLOR_OCHRE="\033[38;5;95m"
#COLOR_BLUE="\033[0;34m"
#COLOR_WHITE="\033[0;37m"
#COLOR_RESET="\033[0m"
## Create git coloring function
#function git_color {
#  local git_status="$(git status 2> /dev/null)"
#  if [[ ! $git_status =~ "working directory clean" ]]; then
#    echo -e $COLOR_RED
#  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
#    echo -e $COLOR_YELLOW
#  elif [[ $git_status =~ "nothing to commit" ]]; then
#    echo -e $COLOR_GREEN
#  else
#    echo -e $COLOR_OCHRE
#fi
#}
#add the git branch etc
#source ~/bin/git-prompt.sh
#function git_branch {
#  local git_status="$(git status 2> /dev/null)"
#  local on_branch="On branch ([^${IFS}]*)"
#  local on_commit="HEAD detached at ([^${IFS}]*)"
#  if [[ $git_status =~ $on_branch ]]; then
#    local branch=${BASH_REMATCH[1]}
#    echo "($branch)"
#  elif [[ $git_status =~ $on_commit ]]; then
#    local commit=${BASH_REMATCH[1]}
#    echo "($commit)"
#  fi
#}
#PS1="\[$WHITE\]\n[\W]"          # basename of pwd
#PS1+="\[\$(git_color)\]"        # colors git status
#PS1+="\[$BLUE\]\$\[$RESET\] "   # '#' for root, else '$'
#PS1='\[\033[38;5;95m\]\u@\h:\[\033[0m\]\[\033[1;36m\]\w\[\033[0m\] \[\033[1;32m\]$(__git_ps1)\[\033[0m\]\$ '
#PS1='\[\033[0;33m\]\t-\[\033[38;5;95m\]\u@\H:\[\033[0m\]\[\033[1;36m\]\w\[\033[0m\] \[\033[1;32m\]$(__git_ps1)\[\033[0m\]\$ '
#PS1='\[\033[0;33m\]\d \t-\[\033[38;5;95m\]\u:\[\033[0m\]\[\033[1;36m\]\w\[\033[0m\] \[\033[1;32m\]$(__git_ps1)\[\033[0m\]\$ ' << use this one
#PS1+="\[\$(git_color)\]$(git status)\[\033[0m\]\$ "        # colors git status
#export PS1

# A two-line colored Bash prompt (PS1) with Git branch and a line decoration
# which adjusts automatically to the width of the terminal.
# Recognizes and shows Git, SVN and Fossil branch/revision.
# Screenshot: http://img194.imageshack.us/img194/2154/twolineprompt.png
# Michal Kottman, 2012
# https://gist.github.com/mkottman/1936195
 
RESET="\[\033[0m\]"
RED="\[\033[0;31m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\033[0;33m\]"
 
PS_LINE=`printf -- '- %.0s' {1..200}`
function parse_git_branch {
  PS_BRANCH=''
  PS_FILL=${PS_LINE:0:$COLUMNS}
  if [ -d .svn ]; then
    PS_BRANCH="(svn r$(svn info|awk '/Revision/{print $2}'))"
    return
  elif [ -f _FOSSIL_ -o -f .fslckout ]; then
    PS_BRANCH="(fossil $(fossil status|awk '/tags/{print $2}')) "
    return
  fi
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  PS_BRANCH="(git ${ref#refs/heads/}) "
}
PROMPT_COMMAND=parse_git_branch
PS_INFO="$GREEN\u@\h$RESET:$BLUE\w"
PS_GIT="$YELLOW\$PS_BRANCH"
PS_TIME="\[\033[\$((COLUMNS-10))G\] $RED[\t]"
export PS1="\${PS_FILL}\[\033[0G\]${PS_INFO} ${PS_GIT}${PS_TIME}\n${RESET}\$ "
#end git branch prompt

#Custom variables
export PATH=/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin:/opt/local/sbin:/Users/swaite/bin:/usr/bin:/opt/local/bin:/opt/local/sbin:~/bin:~/.aws/bin:~/android-studio/bin:/home/swaite/GITREPOS/slog-shiny/.cabal-sandbox/bin:~/minishift-1.13.1-linux-amd64
export EDITOR=vim
#export PS1="[\u@\h \W \$?]\$ "
#QT_STYLE_OVERRIDE plays havoc with dropbox in F24
export QT_STYLE_OVERRIDE=''

#this is a terrible idea
export GIT_SSL_NO_VERIFY=true

#make go work
export GOPATH=/home/swaite/go

#Get funky with git
git config --global alias.lg "log --color --graph --abbrev-commit
           --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset'"

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
alias git-svn='git svn'
alias pushpull='git pull --rebase; git push'

#some taskwarrior shortcuts for managing swimlanes
alias todo="task tags.ToDo"
alias inprogress="task tags.InProgress"
alias i="task tags.InProgress"
alias add="task add +ToDo"
#alias done="task modify -InProgress +Done"
alias start="task modify -ToDo +InProgress"
alias pause="task modify -InProgress +ToDo"

#pop into a Python3 venv
alias chpython="deactivate;source ~/venv/p3/bin/activate"

#shortcuts for xterms
alias brown="/bin/xterm +sb -fg OliveDrab2 -bg sienna4 -fa Mono-10 -geometry 90x45"
alias purple="/bin/xterm +sb -fg MediumOrchid -bg black -fa Mono-10 -geometry 90x45"
alias grey="/bin/xterm +sb -fg AntiqueWhite1 -bg gray30 -fa Mono-10 -geometry 90x45"
alias blue="/bin/xterm +sb -fg gray84 -bg NavyBlue -fa Mono-10 -geometry 90x45"
alias black="/bin/xterm +sb -fg Chartreuse1 -bg Black -fa Mono-10 -geometry 90x45"
alias lblue="/bin/xterm +sb -fg LightGoldenrodYellow -bg DeepSkyBlue4 -fa Mono-10 -geometry 90x45"

#get into the venv
source ~/venv/ssp/bin/activate
#additional files to source
source ~/.bash/RH_alias
source ~/.bash/change_git_name.sh
source ~/.bash/nova_source
#source ~/bin/liquidprompt/liquidprompt 

PATH="/home/swaite/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/swaite/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/swaite/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/swaite/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/swaite/perl5"; export PERL_MM_OPT;
