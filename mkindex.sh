#!/bin/sh

get_dir () {
  find $1 -type d -depth 1 | awk -F '/' '{print $2}' |
  grep -v -e ".git" -e '^[     ]*_' |
  sort
}

echo '' > README.md
get_dir '.' |
while read DIR
do
    echo '' > $DIR/README.md
    echo "- [$DIR]($DIR/README.md)" >> README.md
    get_dir $DIR |
    while read SUB_DIR
    do
      if [ -f $DIR/$SUB_DIR/.template ]
      then
        echo "" > $DIR/$SUB_DIR/README.md
        README_PATH="${SUB_DIR}/README.md"
      else
        README_PATH="${SUB_DIR}"
      fi

      echo "  - [${SUB_DIR}](${DIR}/${README_PATH})" >> README.md
      echo "- [${SUB_DIR}](${README_PATH})" >> $DIR/README.md

      find ${DIR}/${SUB_DIR} -depth 1 -name "*.md" |grep -v -e "README.md"| sort |
      while read MD
      do
          MDPATH=${MD##*/}
          MDNAME=${MDPATH%.md}
          MDDIR=`echo $MD | awk -F'/' '{print $2}'`
          echo "    - [${MDNAME}](${DIR}/${MDDIR}/${MDPATH})" >> README.md
          echo "  - [${MDNAME}](${SUB_DIR}/${MDPATH})" >> $DIR/README.md
      done
      if [ -f $DIR/$SUB_DIR/.template ]
      then
        echo "\n" >> ${DIR}/${SUB_DIR}/README.md
        cat ${DIR}/${SUB_DIR}/.template >> ${DIR}/${SUB_DIR}/README.md
      fi
    done
    find ./${DIR} -depth 1 -name "*.md" |grep -v -e "README.md"| sort |
    while read MD
    do
        MDPATH=${MD##*/}
        MDNAME=${MDPATH%.md}
        MDDIR=`echo $MD | awk -F'/' '{print $2}'`
        echo "  - [${MDNAME}](${MDDIR}/${MDPATH})" >> README.md
        echo "- [${MDNAME}](${MDPATH})" >> ${DIR}/README.md
    done
    echo "\n" >> ${DIR}/README.md
    cat ${DIR}/.template >> ${DIR}/README.md
done
echo "\n" >> README.md
cat .template >> README.md
