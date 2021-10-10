export PATH=/usr/local/mysql/bin:$PATH
export PATH=/Users/nerminsehic/dev/shell:$PATH
export PATH=/Users/nerminsehic/dev/libraries/redis-6.2.4/src:$PATH
export BASH_SILENCE_DEPRECATION_WARNING=1
export PS1="\[\033[95m\]\u@\h \[\033[32m\]\W\[\033[33m\] [\$(git symbolic-ref --short HEAD 2>/dev/null)]\[\033[00m\]\$ "

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/nerminsehic/dev/google-cloud-sdk/path.bash.inc' ]; then . '/Users/nerminsehic/dev/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/nerminsehic/dev/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/nerminsehic/dev/google-cloud-sdk/completion.bash.inc'; fi
