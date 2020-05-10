#!/bin/bash

if [ -z "$REPONAME" ]; 
  then 
    REPONAME=dixaba/test;
fi

if [ $# -gt 0 ];
then
  NAME=$1;
  FILENAME=$(sed -e 's/\-/\./g; s/latest\.\?//; s/$/\.Dockerfile/; s/^\.//' <<< $NAME);
  if [ -e $FILENAME ];
  then
    echo docker build -f $FILENAME -t $REPONAME:$NAME .
    echo VERSION=$(grep -oP 'Using Qt version \K[0-9.]+' <<< $(docker run --rm $REPONAME:$NAME qmake --version));
    
    if [ $# -eq 2 ] && [ $2 = 'tag' ];
      then
        echo docker image tag $REPONAME:$NAME $REPONAME:$(sed "s/latest/$VERSION/" <<< $NAME);
    fi

  else
    echo "No such Dockerfile found!";
  fi
else 
  echo "Provide imagename to build like \"$0 latest\"";
fi