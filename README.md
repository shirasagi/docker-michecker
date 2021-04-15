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
docker run -it --rm --name michecker -v "$PWD":/home -w /home shirasagi/michecker \
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

# UPLOAD

run these commands to upload the new container image to [docker hub](https://hub.docker.com/):

~~~bash
docker login
docker push shirasagi/michecker
~~~
