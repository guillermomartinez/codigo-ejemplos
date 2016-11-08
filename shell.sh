#espacio en disco
df -h
df -k
du -sh
df --output=field1,field2,...
df --output=source,used,avail /data/
df --o
#exclude
df -x ext2

# comprimir
tar -czvf name.tar.gz folder otherfoder
#descomprimir
tar -xzvf name.tar.gz

# size of folder
du -sh folder
du -sch folder
du -h --max-depth=1 folder | sort -hr
find ./ -iname *.mp4 | xargs du -h --max-depth=1 | sort -hr

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
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/.git-prompt.sh
# RED="\[\033[0;31m\]"
# YELLOW="\[\033[0;33m\]"
# GREEN="\[\033[0;32m\]"
# NO_COLOR="\[\033[0m\]"
# PS1="\u@\h:\w$YELLOW$(__git_ps1)\[\e[0m\]$ "
source ~/.git-prompt.sh
PS1='\u@\h \w\[\033[0;33m\]$(__git_ps1)\[\e[0m\]\$ '
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '



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

# goaccess
sudo find /var/log/httpd -type f -name '*log*' -exec cat {} + >> /var/log/out.log
sudo goaccess -f /var/log/httpd/access_log -a -d -H -M -m --date-format '%d/%b/%Y' --log-format '%h %^[%d:%^] "%r" %s %b "%R" "%u"' > /var/www/out.html
sudo goaccess -f /var/log/out.log -a -d -H -M -m --ignore-crawlers --date-format '%d/%b/%Y' --log-format '%h %^[%d:%^] "%r" %s %b "%R" "%u"' > /var/www/out.html

## Install package npm in user folder linux
NPM_PACKAGES="$HOME/.npm-packages"
mkdir -p "$NPM_PACKAGES"
echo "prefix = $NPM_PACKAGES" >> ~/.npmrc
# your .zshrc/.bashrc:
# NPM packages in homedir
NPM_PACKAGES="$HOME/.npm-packages"
# Tell our environment about user-installed node tools
PATH="$NPM_PACKAGES/bin:$PATH"
#unset MANPATH
#MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
# Tell Node about these packages
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

## Cambiar permisos
sudo chmod 775 `find . -type d`
sudo chmod 664 `find . -type f`

