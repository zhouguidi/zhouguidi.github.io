#!/usr/bin/zsh
# get tags
tags=($(grep -e '<li style' _site/blogs/tags/index.html | grep -o '">[^><]*</' | grep -o '[a-zA-Z_0-9]*'))
# template file
tempfn=blogs/page_per_tag.html
# create tags folder
mkdir -p blogs/tags
# delete all subfolders under tags
tagfolds=($(find ./blogs/tags/ -mindepth 1 -type d))
rm -Rf $tagfolds

# for each tag
for tag in $tags; do
    # create folder
    mkdir -p blogs/tags/$tag
    # make index.html from template
    sed -e '1s/^/---\nbelongs: blogs\n---\n/g' -e "s/##TAG##/$tag/" $tempfn > blogs/tags/$tag/index.html
done
