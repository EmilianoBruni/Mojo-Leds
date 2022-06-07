package Mojo::Leds::Page;

use 5.014;    # because s///r usage
use Mojo::Base 'Mojolicious::Controller';
use Mojo::Util qw(class_to_path);

sub route {
    my $s = shift;

    my $format = $s->accepts;
    $format = $format->[0] || 'html' if ( ref($format) eq 'ARRAY' );
    $format =~ s/^(.*?)\.//;    # replace xxxx.js -> js;
    if ( $s->match->path_for->{path} =~ /\.(\w+)$/ ) {

        # force format to file extension
        $format = $1 if ( $format eq 'html' || $format eq 'htm' );
    }
    $s->stash( 'format', $format );

    $s->respond_to(
        html => sub { shift->render_pm },
        json => { json => $s->render_json },
        css  => sub { shift->render_static_file },
        js   => sub { shift->render_static_file },
        any  => { text => '', status => 204 }
    );

}

sub render_pm {
    my $s           = shift;
    my $render_html = $s->render_html;

    # if undef we suppose that &render_html do the render job by itself
    return unless $render_html;
    $s->render_maybe(%$render_html) or $s->reply->not_found;
}

sub render_html {
    my $c = shift;

    # needed for recursive calls (html -> json as an example)
    my $query = $c->req->params->to_hash;
    while ( my ( $k, $v ) = each %$query ) {
        $c->stash( $k => $v );
    }
    return { template => class_to_path( ref($c) ) =~ s/\.pm//r };
}

sub render_json {
    my $c = shift;
    return {};
}

sub render_static_file {
    my $c = shift;

    # optional sub-folder for templates inside app home
    my $dRoot = $c->app->config->{docs_root} || '';

    # indipendently from url, it consider the requested file local to the ctl
    my $ctl_path
        = $c->app->home->rel_file( $dRoot . '/' . class_to_path($c) );

    my $fn = $c->tx->req->url->path->parts->[-1];    # the requested file name
    my $filepath = $ctl_path->dirname()->child($fn);    # filesystem file path
    return $c->reply->not_found unless ( -e $filepath );  # file doen't exists

    my %opt = (
        content_disposition => 'inline',
        filepath            => $filepath,
        format              => $filepath =~ s/(.*^?)\.//r
    );
    $c->render_file(%opt);
}

1;

__END__

# ABSTRACT: Standard page controller for Mojo::Leds

=pod

=encoding UTF-8

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut
