#!/usr/bin/zsh
tags=($(grep -e '<li style' _site/blogs/tags/index.html | grep -o '">[^><]*</' | grep -o '[a-zA-Z 0-9]*'))
tempfn=blogs/page_per_tag.html
for tag in $tags; do
    mkdir -p blogs/tags/$tag
    sed -e '1s/^/---\nbelongs: blogs\n---\n/g' -e "s/##TAG##/$tag/" $tempfn > blogs/tags/$tag/index.html
done
