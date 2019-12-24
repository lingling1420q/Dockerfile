# for acfun post

docker run -ti --rm -e username=$username zhangguanzhang/acfun-dota https://www.youtube.com/watch?v=D6NQ1Z4iH5w

```
set -- xxx
mkdir -p youtube/data
cd youtube
docker pull zhangguanzhang/acfun-dota
docker run --rm -ti -v $PWD/data:/root zhangguanzhang/acfun-dota $1
cat>Dockerfile<<EOF
FROM zhangguanzhang/alpine
COPY data/* /
EOF
docker build -t zhangguanzhang/temp .
docker login -u zhangguanzhang
docker push zhangguanzhang/temp
```
```
temp_dir=`mktemp -u`
docker pull zhangguanzhang/temp
docker run --rm -tid --name temp zhangguanzhang/temp sleep 120
filename=`docker exec temp ls  / | grep -Po '.+?(?=\.mp4)'`
mkdir -p $temp_dir
docker cp temp:/${filename}.mp4 $temp_dir/
docker cp temp:/${filename}.jpg $temp_dir/
docker kill temp
docker run -ti --rm \
  -e username=xxx \
  -v $temp_dir:/root  zhangguanzhang/acfun-dota

rm -rf $temp_dir
```
