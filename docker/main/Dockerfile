# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# AUTHOR  :  Emiliano Bruni <info@ebruni.it>
# DATE    :  2021-07-28
# PURPOSE :
#   Generate a docker image with all necessary components required to Mojo::Leds [https://metacpan.org/pod/Mojo::Leds] framework components
#
#   This image is published in docker hub with handle: ebruni/mojo-leds
#
# USAGE:
#   docker build -t mojo-leds .
#
# UPDATES:
#   AUTHOR          DATE        VERSION   COMMENTS
#   Emiliano Bruni  2021-07-29  1.0       Initial Version
#   Emiliano Bruni  2021-08-09  1.1       Create default app
#   Emiliano Bruni  2021-08-23  1.2       Standard starup & mongodb/micso tags
#   Emiliano Bruni  2021-08-24  1.3       Reduced image size
#   Emiliano Bruni  2021-09-07  1.4       Update to latest mojolicious:minion
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#

#
# this file is generated via docker-builder
#
# do not edit it directly
#
FROM ebruni/mojolicious
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
  && apk del \
    make \
    gcc \
    perl-dev \
  && true

ARG NOW=not-set
LABEL org.opencontainers.image.authors="Emiliano Bruni <info@ebruni.it>"
LABEL org.opencontainers.image.created=$NOW
LABEL org.opencontainers.image.description="Generate a docker image with all necessary components required to Mojo::Leds [https://metacpan.org/pod/Mojo::Leds] framework components"
LABEL org.opencontainers.image.documentation=https://github.com/EmilianoBruni/Mojo-Leds/blob/master/README.pod
LABEL org.opencontainers.image.licenses=Artistic-2.0
LABEL org.opencontainers.image.source=https://github.com/EmilianoBruni/Mojo-Leds/blob/master/main/Dockerfile
LABEL org.opencontainers.image.title=Mojo-Leds
LABEL org.opencontainers.image.url=https://github.com/EmilianoBruni/Mojo-Leds
LABEL org.opencontainers.image.version=1.3

CMD ["/bin/bash", "-c"]
