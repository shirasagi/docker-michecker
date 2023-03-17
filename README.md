michecker container for shirasagi
====

This container is intended to use with shirasagi.
We hope this container could be useful for production.

# BUILD

run these commands:

~~~bash
docker build -t shirasagi/michecker .
~~~

# RUN

run these commands:

~~~bash
docker run --rm --name michecker -v "$PWD":/home -w /home shirasagi/michecker \
  /opt/michecker/bin/michecker --no-interactive --no-sandbox --lang=ja-JP \
  --html-checker-output-report=hc-report.json \
  --lowvision-output-report=lv-report.json \
  --lowvision-source-image=lv-source.png \
  --lowvision-output-image=lv-output.png \
  "https://www.ss-proj.org/"
~~~

and open hv-resport.json to view html accessibility check results,
lv-report.json to view low-vision check results,
lv-source.png to view browser image
and lv-output.png to view low-vision simulation result.

# UPLOAD to GitHub Container Registry

Before you upload your image, you should put a tag to your image.

1. Find the ID for the Docker image you want to tag.
  ~~~
  docker images
  ~~~
2. Tag your Docker image using the image ID and your desired image name and hosting destination.
  ~~~
  docker tag 38f737a91f39 ghcr.io/shirasagi/michecker:latest
  ~~~

Then run these commands to upload the new container image to [GitHub Container Registry](https://github.com/orgs/shirasagi/packages):

~~~bash
export CR_PAT=YOUR_TOKEN
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
docker push ghcr.io/shirasagi/michecker
~~~

YOUR_TOKEN is a personal access token created on the github your account page with "write:packages" scope, and USERNAME is your github account id.

# SHIRASAGI との統合

## docker container 内からシラサギの管理画面へアクセスできる場合

### シラサギの設定

1. SHIRASAGI をデプロイしたディレクトへ移動。
2. config/michecker.yml （存在しない場合 config/defaults/michecker.yml を config/michecker.yml へコピー）をテキストエディタで開く。
3. `disable: true` を `disable: false` へ変更。
4. `command: [...]` を `command: [ "bin/docker-michecker.sh" ]` へ変更。
5. config/michecker.yml を保存し SHIRASAGI を再起動。

## docker container 内からシラサギの管理画面へアクセスできない場合

「docker container 内からシラサギの管理画面へアクセスできる場合」の「シラサギの設定」を参考に docker container の michecker とシラサギとを統合します。

そして、シラサギを起動し、CMS のサイト情報の編集から「マイページドメイン」にIPアドレスを設定します。ここで設定する IP アドレスはホストがもつ IP アドレスの内 127.0.0.1 以外の IP アドレス（docker container 内からアクセスできる IP アドレスであれば何でも構いません）を設定します。

最後に、同じ画面の「マイページスキーム」が正しいかどうか確認し、保存します。
これで利用できるようになると思います。

## docker container 内からシラサギの管理画面へアクセスできるかどうかの見分け方

次のコマンドを実行し HTML が正しく表示されれば、docker container 内からシラサギの管理画面へアクセスできます。

~~~
docker run --rm -it shirasagi/michecker \
  /opt/google/chrome/chrome --headless --no-sandbox --disable-gpu --dump-dom \
  https://シラサギの管理画面のdomain/.mypage/login
~~~

次のように `<body></body>` が空の HTML が表示されれば、docker container 内からシラサギの管理画面へはアクセスできません。

~~~
<html><head></head><body></body></html>
~~~
