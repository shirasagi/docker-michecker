FROM openjdk:8u282-jre
LABEL maintainer="NAKANO Hideo <nakano@web-tips.co.jp>"

# update OS and install prerequisities
RUN apt-get update && apt install -y gnupg

# setup google-chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && apt install -y ./google-chrome-stable_current_amd64.deb \
  && rm google-chrome-stable_current_amd64.deb

# setup noto fonts
RUN apt install -y fonts-noto-cjk \
  && fc-cache -f

# setup michecker
ADD ./assets/michecker.tar.bz2 /opt

# finalize setup
RUN apt clean && rm -rf /var/lib/apt/lists/
