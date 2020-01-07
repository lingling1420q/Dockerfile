#!/bin/sh
set -e
[[ "${DEBUG}" == "true" ]] && set -x
cd /root/data
down(){
    youtube-dl --write-thumbnail \
    --embed-sub \
    --write-sub \
    -f "bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best" --merge-output-format mp4 -o "a${1#*=}.%(ext)s" $@
}
if [ "${#@}" -ge 1 ];then
  url="$@"
  down "$url"
fi
if [ -n "$username" ];then
    ls -lh
    if [ -n "$auto" ];then
        name=$(youtube-dl -f mp4 -o '%(id)s.%(ext)s' --print-json --no-warnings "$url" | jq -r .title)
    else
	read -p 'input the title name: ' name
    fi
    [ -z "$password" ] && {
        read -sp 'password: ' password
        echo
    }

    acfun -u ${username} -p ${password} -n "${name}" --pic $(ls | grep .jpg) $(ls | grep -v jpg)
fi
