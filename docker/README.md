<!-- this file is generated via docker-builder, do not edit it directly -->


# What is Mojo::Leds?

Mojo::Leds is a docker image with all necessary components required to Mojo::Leds [https://metacpan.org/pod/Mojo::Leds] framework components .

All images, unless explicitly defined, are based on [ebruni/mojolicious](https://hub.docker.com/repository/docker/ebruni/mojolicious) and provide installed together with these Perl modules:

* [Mojo::Leds](https://metacpan.org/pod/Mojo::Leds) v1.12.

# Supported tags and respective Dockerfile links

* Mojo::Leds: [1.9, latest (main/Dockerfile)](https://github.com/EmilianoBruni/Mojo-Leds/blob/master/main/Dockerfile) (size: **57.6MB**)

* Mojo::Leds: [1.9-micso-mongodb, micso-mongodb (micso-mongodb/Dockerfile)](https://github.com/EmilianoBruni/Mojo-Leds/blob/master/micso-mongodb/Dockerfile) (size: **72.1MB**) based on [ebruni/minion-backend-mongodb:mongodb](https://hub.docker.com/repository/docker/ebruni/minion-backend-mongodb) with these additional Perl modules

	* [Mojolicious::Plugin::Restify::OtherActions](https://metacpan.org/pod/Mojolicious::Plugin::Restify::OtherActions) v0.04,
	* [Mojolicious::Plugin::AccessLog](https://metacpan.org/pod/Mojolicious::Plugin::AccessLog) v0.010001,
	* [Mojolicious::Plugin::AutoReload](https://metacpan.org/pod/Mojolicious::Plugin::AutoReload) v0.010,
	* [Mojolicious::Plugin::LinkedContent::v9](https://metacpan.org/pod/Mojolicious::Plugin::LinkedContent::v9) v0.10.
* Mojo::Leds: [1.9-mongodb, mongodb (mongodb/Dockerfile)](https://github.com/EmilianoBruni/Mojo-Leds/blob/master/mongodb/Dockerfile) (size: **62.2MB**) based on [ebruni/mojolicious:mongodb](https://hub.docker.com/repository/docker/ebruni/mojolicious) with these additional Perl modules

	* [Mojolicious::Plugin::Restify::OtherActions](https://metacpan.org/pod/Mojolicious::Plugin::Restify::OtherActions) v0.04.

# How to use this image

## Generate an example application.

Go to your code folder, call Mojolicious to create the basic application
structure with you as the owner.

    $ docker run --rm -v "$(pwd):/var/www" ebruni/mojo-leds:latest mojo generate leds_app MyApp

Start the application as daemon.

    $ cd my_app
    $ docker container run -d --rm -v "$(pwd):/var/www" -p 3000:3000 ebruni/mojo-leds morbo script/my_app

To run the container in the foreground and read the output, omit the `-d` and add `-ti`.

    $ docker container run --rm -ti -v "$(pwd):/var/www" -p 3000:3000 ebruni/mojo-leds morbo script/my_app

Browse to [localhost:3000](http://localhost:3000) and edit the code in the
current folder. If you are on Linux or MacOS, the server will restart whenever
you change a file. On Windows this works if you use Docker Desktop with WSL 2.

To switch from development to production an run the application as daemon in
the full featured non-blocking web server start it with

    $ docker container run -d --rm -v "$(pwd):/var/www" -p 3000:3000 ebruni/mojo-leds morbo script/my_app prefork

# Authors

Emiliano Bruni (EB) <info@ebruni.it>

# Changes

| AUTHOR | DATE | VER. | COMMENTS |
|:---|:---:|:---:|:---|
| EB | 2021-11-17 | 1.9 | Update to Mojo::Leds v.1.12 |
| EB | 2021-11-04 | 1.8 | Update to Minion::Backend::MongoDB v.1.12 |
| EB | 2021-09-24 | 1.7 | Update to Mojo::Leds v.1.11 and backend v.1.10 |
| EB | 2021-09-20 | 1.6 | Update to Mojo::Leds 1.10 |
| EB | 2021-09-09 | 1.5 | Update to latest parent container |
| EB | 2021-09-07 | 1.4 | Update to latest mojolicious:minion |
| EB | 2021-08-24 | 1.3 | Reduced image size |
| EB | 2021-08-23 | 1.2 | Standard starup & mongodb/micso tags |
| EB | 2021-08-09 | 1.1 | Create default app |
| EB | 2021-07-29 | 1.0 | Initial Version |

# Source

The source of this image on [GitHub](https://github.com/EmilianoBruni/Mojo-Leds).
