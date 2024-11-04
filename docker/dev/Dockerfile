FROM ebruni/devel:dzil

ARG IDIR

WORKDIR /usr/src/Mojo-Leds

RUN apk add --no-cache sudo shadow && \
    rm -rf /var/cache/apk/* && \
    adduser -g "Developer" -D -u 1001 dev && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/dev 

COPY . .
RUN { [ -f dist.ini ] && \
    dzil listdeps | cpanm --no-wget --notest || true; } \
    && { [ -d /root/.cpanm ] \
    && rm -r /root/.cpanm || true; }

CMD [""]