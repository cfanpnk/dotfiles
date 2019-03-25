export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export AIRFLOW_HOME=~/airflow
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH="/usr/local/opt/elasticsearch@5.5/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"
export ZPLUG_HOME=/usr/local/opt/zplug

[ -f /usr/local/etc/profile.d/autojump.sh  ] && . /usr/local/etc/profile.d/autojump.sh

set -g @continuum-restore 'on'
set -g @continuum-boot-options 'iterm'
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZPLUG_HOME/init.zsh
fpath=(/usr/local/share/zsh-completions $fpath)

[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
eval "$(rbenv init -)"

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

source ~/.zplug/init.zsh

zplug 'mafredri/zsh-async'
zplug 'sindresorhus/pure'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-completions', defer:2

zplug load

autoload -U promptinit; promptinit
prompt pure
