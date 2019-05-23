#!/bin/sh
echo '' > README.md
find . -type d -depth 1 | awk -F '/' '{print $2}' |
grep -v -e ".git" -e '^[     ]*_' |
sort |
while read DIR
do
    echo '' > $DIR/README.md
    echo "- [$DIR]($DIR)" >> README.md
    find ./$DIR -name "*.md" |grep -v -e "README.md"| sort |
    while read MD
    do
        MDPATH=${MD##*/}
        MDNAME=${MDPATH%.md}
        MDDIR=`echo $MD | awk -F'/' '{print $2}'`
        echo "  - [$MDNAME]($MDDIR/$MDPATH)" >> README.md
        echo "  - [$MDNAME]($MDPATH)" >> $DIR/README.md
    done
    echo "\n" >> $DIR/README.md
    cat $DIR/.template >> $DIR/README.md
done
echo "\n" >> README.md
cat .template >> README.md
