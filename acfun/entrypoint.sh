#!/bin/sh
set -e
[[ "${DEBUG}" == "true" ]] && set -x
down(){
    youtube-dl --write-thumbnail \
    --embed-sub \
    --write-sub \
    -f "bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4 -o "a${1#*=}.%(ext)s" $1
}
url="$1"
down "$url"
ls -lh
read -p 'input the title name: ' name
[ -z "$password" ] && {
    read -sp 'password: ' password
    echo
}

acfun -u ${username} -p ${password} -n "${name}" --pic $(ls | grep .jpg) $(ls | grep -v jpg)
