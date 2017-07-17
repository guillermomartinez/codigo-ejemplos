# copiar
rsync --dry-run -av --exclude='.git' --exclude='folder' datos/* html/
rsync -av --exclude='.git' --exclude='folder' datos/* html/
# copiar solo la diferencia de origen a destino
rsync -auv --exclude='.git' --exclude='folder' datos/* html/

# buscar
find folder/ -type f -name "*.php"
find . -mtime -1 -ls | head -3

#espacio en disco
df -h
df -k
du -sh
df --output=field1,field2,...
df --output=source,used,avail /data/
df --o
#exclude
df -x ext2

# comprimir por partes
tar -cvzf - folder | split -b 150M - "archive-part-"
# descomprimir y unir partes
cat archive-part-* | tar xz

# comprimir
tar -czvf name.tar.gz folder otherfoder
tar -czvf name.tar.gz folder otherfoder --exclude='folder1' --exclude='folder2'

zip archivos-comprimidos.zip archivo1 archivo2 archivo3
# todos los archivos
zip archivos.zip *
# todo un directorio
zip -r directorio-comprimido.zip /home/usuario

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
sudo find . -type d -exec chmod -R 755 {} \;
sudo find . -type f -exec chmod -R 644 {} \;

#!/bin/bash

TEST_URL="http://domain.com/"

FIREFOX_USERAGENT_STRING="Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14"
GOOGLEBOT_USERAGENT_STRING="Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"

#get page for firefox browser
rm firefox.html
wget -c --user-agent="$FIREFOX_USERAGENT_STRING" --output-document=firefox.html "$TEST_URL"

#get page for google bot
rm googlebot.html
wget -c --user-agent="$GOOGLEBOT_USERAGENT_STRING" --output-document=googlebot.html "$TEST_URL"

<Directorymatch "^/.*/\.git/">
Order deny,allow
Deny from all
</Directorymatch>


sudo mount -t vboxsf -o uid=1000,gid=1000 vagrant /vagrant

nmap -sV --script http-wordpress-enum --script-args www.domain.com
