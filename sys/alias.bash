################################################################
alias uu='sudo apt-get update && sudo apt-get upgrade -y'
alias cl='clear'
alias hn='hostname -I'

alias gb='gedit ~/.bashrc'
alias cb='code ~/.bashrc'
alias sb='source ~/.bashrc'

alias acm='ls -l /dev | grep ttyACM'
alias usb='ls -l /dev | grep ttyUSB'
alias i2c='i2cdetect -r -y 1'
alias js='ls -l /dev/input/js*'

alias ga='git add'
alias gs='git status'
alias gp='git pull'

alias gaa='git add .'
alias gcm='git commit -a -m "Update"'
alias gph='git push -u origin ubuntu-18.04'

IP_ADDR=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}')
export IP_ADDR
alias IP='echo $IP_ADDR'
