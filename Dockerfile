FROM python:3.10

RUN apt-get update && \
    apt-get install --no-install-recommends -y software-properties-common gpg-agent libmediainfo-dev gosu && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget "https://github.com/notofonts/noto-cjk/blob/main/Sans/Variable/TTF/Mono/NotoSansMonoCJKjp-VF.ttf?raw=true" -O /usr/local/share/fonts/NotoSansMonoCJKjp-VF.ttf && \
 fc-cache -f -v
RUN python3 -m pip install av pymediainfo pillow==9.5 git+https://github.com/michibiki-io/pyvideothumbnailer.git@master
RUN groupadd -r pyuser && useradd -l -r -g pyuser pyuser
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["pyvideothumbnailer","--background-color","black","--header-font-color","white","--header-font","/usr/local/share/fonts/NotoSansMonoCJKjp-VF.ttf","--timestamp-font","/usr/local/share/fonts/NotoSansMonoCJKjp-VF.ttf","--width","1280","--columns","5","--rows","4","--output-directory","thumbs","--recursive"],
