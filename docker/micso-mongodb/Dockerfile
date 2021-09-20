# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# AUTHORS :  Emiliano Bruni (EB) <info@ebruni.it>
# DATE    :  2021-09-20
# PURPOSE :
#   Docker image with all necessary components required to Mojo::Leds [https://metacpan.org/pod/Mojo::Leds] framework components .
#
#   This image is published in docker hub with handle: ebruni/mojo-leds
#
# USAGE:
#   docker build -t mojo-leds .
#
# UPDATES:
#   AUTHOR  DATE        VER  COMMENTS
#   EB      2021-09-20  1.6  Update to Mojo::Leds 1.10
#   EB      2021-09-09  1.5  Update to latest parent container
#   EB      2021-09-07  1.4  Update to latest mojolicious:minion
#   EB      2021-08-24  1.3  Reduced image size
#   EB      2021-08-23  1.2  Standard starup & mongodb/micso tags
#   EB      2021-08-09  1.1  Create default app
#   EB      2021-07-29  1.0  Initial Version
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#

#
# this file is generated via docker-builder
#
# do not edit it directly
#
FROM ebruni/minion-backend-mongodb:mongodb
MAINTAINER Emiliano Bruni <info@ebruni.it>

WORKDIR /var/www
EXPOSE 3000 9091

RUN apk update && apk add --no-cache \
    make \
    gcc \
    perl-dev \
  && cpanm --no-wget -n \
    Mojo::Leds \
  && rm -r /root/.cpanm \
 && apk add --no-cache \
    perl-lwp-protocol-https \
&& cpanm --no-wget -n \
    Mojolicious::Plugin::Restify::OtherActions \
    Mojolicious::Plugin::AccessLog \
    Mojolicious::Plugin::AutoReload \
    Mojolicious::Plugin::LinkedContent::v9 \
  && rm -r /root/.cpanm \
  && apk del \
    make \
    gcc \
    perl-dev \
  && true

ARG NOW=not-set
LABEL org.opencontainers.image.authors="Emiliano Bruni <info@ebruni.it>"
LABEL org.opencontainers.image.created=$NOW
LABEL org.opencontainers.image.description="docker image with all necessary components required to Mojo::Leds [https://metacpan.org/pod/Mojo::Leds] framework components ."
LABEL org.opencontainers.image.documentation=https://github.com/EmilianoBruni/Mojo-Leds/blob/master/README.pod
LABEL org.opencontainers.image.licenses=Artistic-2.0
LABEL org.opencontainers.image.source=https://github.com/EmilianoBruni/Mojo-Leds/blob/master/micso-mongodb/Dockerfile
LABEL org.opencontainers.image.title=Mojo::Leds
LABEL org.opencontainers.image.url=https://github.com/EmilianoBruni/Mojo-Leds
LABEL org.opencontainers.image.version=1.6-micso-mongodb

CMD ["/bin/bash", "-c"]
