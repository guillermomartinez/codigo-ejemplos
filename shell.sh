# rename files
NUM=0;
DIR="folder/";
PREFIJO="image";
for FILE in $DIR* ;
	do 
	NUM=`expr $NUM + 1`; 
	FILEEXT=`echo ${FILE##*.}`;
	NEWFILE=`echo $DIR$PREFIJO$NUM.$FILEEXT`;
	# echo $FILE;
	# echo $NEWFILE;
	mv $FILE $NEWFILE; 
done
## Activar branch name in current promt
sudo apt-get install bash-completion
vim ~/.bashrc
# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOR="\[\033[0m\]"
export PS1="\u@\h:\w$YELLOW$(__git_ps1)\[\e[0m\]$ "
# export PS1='\u@\h:\w\[\033[0;33m\]$(__git_ps1)\[\e[0m\]$ '
