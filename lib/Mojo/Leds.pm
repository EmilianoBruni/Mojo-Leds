package Mojo::Leds;

use Mojo::Base 'Mojolicious';
use Mojo::Log;

sub startup() {
    my $s = shift;

    # log
	$s->app->log( Mojo::Log->new(
		path => $s->home->rel_file('/logs/app.log'),
		level => 'info'
	) ) unless ($s->app->mode eq 'development');;

    # plugins
    $s->plugin(Config => {file => 'cfg/app.cfg'});
    # lo leggo due volte per valorizzare dentro al cfg app->config->...
    $s->plugin(Config => {file => 'cfg/app.cfg'});

    if (my $plugins = $s->config->{plugins}) {
        while (my ($k,$v) = each %$plugins) {
            $s->plugin($k,$v);
        }
    }

	# global configurations
    my $cfg = $s->config;
	$s->secrets($cfg->{secret});
	$s->sessions->default_expiration($cfg->{session}->{default_expiration});
	$s->sessions->cookie_name($cfg->{session}->{name});

	# la root dei file statici
    my $docs_root = $s->config->{docs_root};
	push @{$s->app->static->paths}, $s->home->rel_file("$docs_root/public");
	# ridefinisco la root dei template
	$s->app->renderer->paths->[0] =
        $s->home->rel_file($docs_root)->to_string;
}

1;
__END__

# ABSTRACT: Leds aka Light Environment (emi) for Development System based on Mojolicious

=pod

=encoding UTF-8

=begin :badge

=begin html

<p><img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/EmilianoBruni/mojolicious-plugin-mongodbv2?style=plastic"> <a href="https://travis-ci.com/EmilianoBruni/Mojo-Leds"><img alt="Travis tests" src="https://img.shields.io/travis/com/EmilianoBruni/Mojo-Leds?label=Travis%20tests&style=plastic"></a></p>

=end html

=end :badge

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 BUGS/CONTRIBUTING

Please report any bugs through the web interface at L<https://github.com/EmilianoBruni/Mojo-Leds/issues>
If you want to contribute changes or otherwise involve yourself in development, feel free to fork the Git repository from
L<https://github.com/EmilianoBruni/Mojo-Leds/>.

=head1 SUPPORT

You can find this documentation with the perldoc command too.

    perldoc Mojo::Leds

=cut
