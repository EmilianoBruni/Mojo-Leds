FROM ebruni/mojolicious

ARG IDIR

ENV TZ="Europe/Rome"

RUN apk add --no-cache tzdata sudo shadow git build-base perl-dev musl-dev && \
    rm -rf /var/cache/apk/* && \
    adduser -g "Developer" -D -u 1001 dev && \
    echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/dev 

USER dev

WORKDIR /ws/${IDIR}

CMD [""]