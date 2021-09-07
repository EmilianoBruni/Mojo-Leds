
<!-- this file is generated via docker-builder, do not edit it directly -->

# What is Mojo-Leds?

Mojo-Leds is Generate a docker image with all necessary components required to Mojo::Leds [https://metacpan.org/pod/Mojo::Leds] framework components

The images are based on ebruni/mojolicious and provide installed together with this perl modules:
[Mojo::Leds](https://metacpan.org/pod/Mojo::Leds).

# Supported tags and respective Dockerfile links

* Mojo-Leds: [1.4, latest (main/Dockerfile)](https://github.com/EmilianoBruni/Mojo-Leds/blob/master/main/Dockerfile) (size: **57.6MB**)
* Mojo-Leds: [1.4-mongodb, mongodb (mongodb/Dockerfile)](https://github.com/EmilianoBruni/Mojo-Leds/blob/master/mongodb/Dockerfile) (size: **61.6MB**)
with library
	* [Mojolicious::Plugin::Mongodbv2](https://metacpan.org/pod/Mojolicious::Plugin::Mongodbv2),
	* [Mojolicious::Plugin::Restify::OtherActions](https://metacpan.org/pod/Mojolicious::Plugin::Restify::OtherActions).
* Mojo-Leds: [1.4-micso-mongodb, micso-mongodb (micso-mongodb/Dockerfile)](https://github.com/EmilianoBruni/Mojo-Leds/blob/master/micso-mongodb/Dockerfile) (size: **113MB**)
with library
	* [Mojolicious::Plugin::Restify::OtherActions](https://metacpan.org/pod/Mojolicious::Plugin::Restify::OtherActions),
	* [Mojolicious::Plugin::AccessLog](https://metacpan.org/pod/Mojolicious::Plugin::AccessLog),
	* [Mojolicious::Plugin::AutoReload](https://metacpan.org/pod/Mojolicious::Plugin::AutoReload),
	* [Mojolicious::Plugin::LinkedContent::v9](https://metacpan.org/pod/Mojolicious::Plugin::LinkedContent::v9).

# How to use this image

Start the application as

    $ docker run --rm -ti ebruni/mojo-leds

# Source

The source of this image on [GitHub](https://github.com/EmilianoBruni/Mojo-Leds).
