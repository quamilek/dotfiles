# MacPorts Installer addition on 2013-06-05_at_09:44:24: adding an appropriate PATH variable for use with MacPorts.
#export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# aliases
alias ll='ls -aliG'
alias ls='ls -lG'
alias lgog='git log --pretty=format:"%h %su%x09 (%an - %ad)" --date=short'
alias glog='git log --pretty=oneline --abbrev-commit -n 10'
alias glogm='git log --pretty=oneline --abbrev-commit -n 10 --no-merges develop'
alias rmpyc='find . -name "*.pyc" | xargs -I {} rm -v "{}"'
#brew 
alias start-redis='redis-server /usr/local/etc/redis.conf'
alias tools-activate="source ~/workspace/tools/bin/activate"

alias start-vagrant-ralph="cd ~/virtual_machines/ && vagrant up && vagrant ssh"
alias fap="~/workspace/tools/bin/fab -f ~/workspace/tools/project/fabfile.py $1"

# path
#export PATH=$PATH:/opt/local/lib/mysql5/bin

function settitle() { echo -n -e "\033]0;$1\007"; }
export -f settitle

export CLICOLOR=1

export LSCOLORS in git repo
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
        dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$"`
        untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$"`
        ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$"`
        newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$"`
        renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$"`
        deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$"`
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
                echo "${bits}"
        else
                echo ""
        fi
}

export PS1="quamilek:\w\[\e[32m\]\`parse_git_branch\`\[\e[m\]\$ "
source ~/.git-completion.sh
