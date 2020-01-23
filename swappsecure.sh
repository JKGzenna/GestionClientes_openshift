#!/bin/bash
set -e
set -u
set -o pipefail

TMPDIR=`mktemp -d`
REMEMBER="Be careful, don't push any file without the .encrypt extension"
BYE="bye ¯\_(ツ)_/¯"
VERSION="1.0"

function convert() {
    echo "Starting file convert from zip to tar"
    #Copy the zip to the temporary directory
    cp "$FILE" $TMPDIR/
    # File and Path file 
    ONLYFILE=$(echo $FILE | awk -F'/' '{print $NF}')
    PATHFILE=$(echo $FILE | awk 'BEGIN{FS=OFS="/"}{NF--; print}')
    #Unzip
    (cd $TMPDIR && unzip -q "$ONLYFILE")
    #Remove the original zipfile because we don't want that to be tar'd
    rm "$TMPDIR/$ONLYFILE"
    #Tar the files
    outfilename=$(echo "$ONLYFILE" | rev | cut -d. -f2- | rev).tar
    (cd $TMPDIR && tar cf "$outfilename" *)
    if [ -z $PATHFILE ]
    then
   	 mv "$TMPDIR/$outfilename" . 
    else
    	mv "$TMPDIR/$outfilename" $PATHFILE
    fi
    #Remove the temporary directory
    rm -rf $TMPDIR
    #Print what we did
    echo -e "\e[32mConverted $FILE to $outfilename\e[0m" 
}

function encrypt() {
    echo "Starting file encrypting"
    outfilename=$(echo "$FILE" | rev | cut -d. -f2- | rev).tar
    newfilename=$(echo "$FILE" | rev | cut -d. -f2- | rev).encrypt
    echo $newfilename
    openssl enc -md md5 -aes-256-cbc -in $outfilename -out $newfilename
    if [ $? -eq 0 ]
    then
    echo -e "\e[32mfile secured with openssl\e[0m"
    echo "remove uncrypt file $outfilename"
    rm $outfilename
    fi
    echo $REMEMBER
}

function decrypt() {
    echo "Starting file decrypt"
    outfilename=$(echo "$FILE" | rev | cut -d. -f2- | rev).encrypt
    newfilename=$(echo "$FILE" | rev | cut -d. -f2- | rev).tar
    echo $outfilename
    openssl enc -md md5 -aes-256-cbc -d -in $outfilename > $newfilename
    if [ $? -eq 0 ]
    then
    echo "file unsecured"
    echo "remove encrypt file $outfilename"
    rm $outfilename
    fi
    echo $REMEMBER
}

function print_usage() {
      echo ""
      echo "script usage: $(basename $0) -f file.zip [-c convert to tar and encrypt] [-e only encrypt file .uncrypt] [-d decrypt files encrypted]" >&2
      echo ""
      echo $VERSION
      exit 1
}

while getopts 'f:h:cde' OPTION; do
  case "$OPTION" in
    f)
      FILE="$OPTARG"
      ;;
    c)
      echo "The file to convert and secured is $FILE"
      read -p "Are you sure? Y/N " -n 1 -r
      echo ""
      if [[ $REPLY =~ ^[Yy]$ ]]
      then
      convert
      encrypt
      else
      echo "$BYE"
      exit 1
      fi
      ;;
    d)
      echo "The file to decrypt is $FILE"
      read -p "Are you sure? Y/N " -n 1 -r
      echo ""
      if [[ $REPLY =~ ^[Yy]$ ]]
      then
      decrypt
      else
      echo "$BYE"
      exit 1
      fi
      ;;
    e)
      echo "The file to encrypt is $FILE"
      read -p "Are you sure? Y/N " -n 1 -r
      echo ""
      if [[ $REPLY =~ ^[Yy]$ ]]
      then
      encrypt
      else
      echo "$BYE"
      exit 1
      fi
      ;;
    ?)
      print_usage
      exit 1
      ;;
  esac
done

shift "$(($OPTIND -1))"
