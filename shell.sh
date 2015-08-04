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
