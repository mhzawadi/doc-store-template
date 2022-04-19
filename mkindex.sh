#!/bin/sh

branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')

get_dir () {
  find $1 -type d -depth 1 | awk -F '/' '{print $2}' |
  grep -v -e ".git" -e '^[     ]*_' |
  sort
}

set_tags(){
  FILE=$1
  tags=$(/usr/bin/grep '^tags' $FILE | /usr/bin/awk -F ': ' '{printf(" %s", $2)}')
  echo "$tags"
}

echo '' > README.md
get_dir '.' |
while read DIR
do
    echo '' > $DIR/README.md
    echo "- [$DIR]($DIR/README.md)" >> README.md
    if [ -x "/usr/local/bin/nwdiag" ]
    then
      find $DIR -depth 1 -name "*.diag" |
      while read DIAG
      do
        filename=$(basename "$DIAG")
        fname="${filename%.*}"
        nwdiag --no-transparency -o "${DIR}/${fname}.png" "${DIAG}"
        echo "## ${fname}" >> $DIR/README.md
        echo "![${fname}](https://github.com/may-den/devsysops-docs/blob/${branch}/${DIR}/${fname}.png \"${fname}\")" >> $DIR/README.md
        echo '------' >> $DIR/README.md
      done
    fi
    get_dir $DIR |
    while read SUB_DIR
    do
      echo "  - [$SUB_DIR]($DIR/$SUB_DIR)" >> README.md
      echo "- [$SUB_DIR]($SUB_DIR)" >> $DIR/README.md
      find $DIR/$SUB_DIR -depth 1 -name "*.md" |grep -v -e "README.md"| sort |
      while read MD
      do
          MDPATH=${MD##*/}
          MDNAME=${MDPATH%.md}
          MDDIR=`echo $MD | awk -F'/' '{print $2}'`
          echo "    - [$MDNAME]($DIR/$MDDIR/$MDPATH)$(set_tags "$DIR/$MDDIR/$MDPATH")" >> README.md
          echo "  - [$MDNAME]($SUB_DIR/$MDPATH)$(set_tags "$DIR/$MDDIR/$MDPATH")" >> $DIR/README.md
      done
    done
    find ./$DIR -depth 1 -name "*.md" |grep -v -e "README.md"| sort |
    while read MD
    do
        MDPATH=${MD##*/}
        MDNAME=${MDPATH%.md}
        MDDIR=`echo $MD | /usr/bin/awk -F'/' '{print $2}'`
        echo "  - [$MDNAME]($MDDIR/$MDPATH)$(set_tags "$MDDIR/$MDPATH")" >> README.md
        echo "- [$MDNAME]($MDPATH)$(set_tags "$MDDIR/$MDPATH")" >> $DIR/README.md
    done
    echo "\n" >> $DIR/README.md
    cat $DIR/.template >> $DIR/README.md
done
echo "\n" >> README.md
cat .template >> README.md
