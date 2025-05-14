
alias uu='sudo apt-get update && sudo apt-get upgrade -y'
alias cl='clear'
alias hn='hostname -I'

alias gb='gedit ~/.bashrc'
alias sb='source ~/.bashrc'

IP_ADDR=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}')
export IP_ADDR
alias IP='echo $IP_ADDR'

alias gs='git status'
alias gp='git pull'