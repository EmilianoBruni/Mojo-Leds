package Mojo::Leds::Page;

use Mojo::Base 'Mojolicious::Controller';
use experimental qw( switch );

our $VERSION = "0.3";

sub route {
    my $s = shift;

    my $format = $s->accepts;
    $s->app->types->type(
        js         => 'application/javascript',
        css        => 'text/css',
        xls        => 'application/vnd.ms-excel',
        text       => 'text/plain',
        txt        => 'text/plain',
        'model.js' => 'application/javascript',
    );
    $format = $format->[0] || 'html' if ( ref($format) eq 'ARRAY' );
    if ( $s->match->path_for->{path} =~ /\.(\w+)$/ ) {

        # forzo il formato dell'estensione del file richiesto
        $format = $1 if ( $format eq 'html' || $format eq 'htm' );
    }

    # occhio che respond_to non va bene perche' sembra chiamare
    # comunque tutte le funzioni
    given ($format) {
        when (/^html?/) { my $r = $s->render_html; $s->render(%$r) if ($r) }
        when ('txt')    { my $r = $s->render_html; $s->render(%$r) if ($r) }
        when ('json')   { $s->render( json => $s->render_json ) }
        when ('text')   { $s->render( text => $s->render_text ) }

        # match xxx.model.js ad esempio
        when (/^(\w+\.)?js$/)  { $s->render_static_file($format) }
        when (/^(\w+\.)?css$/) { $s->render_static_file($format) }
        default                { $s->render( { text => '', status => 204 } ) }
    }
}

sub render_html {
    my $c = shift;

    # per uso in successive chiamate (html -> json ad esempio)
    my $query = $c->req->params->to_hash;
    $c->session->{query} = $query;
    while ( my ( $k, $v ) = each %$query ) {
        $c->stash( $k => $v );
    }
    return { template => Mojo::Util::class_to_path( ref($c) ) =~ s/\.pm//r };
}

sub render_json {
    my $c = shift;
    return {};
}

sub render_text {
    my $c = shift;

    my $json  = $c->render_json;    # default try to get json data from page
    my $data0 = $json->{data0};     # json => {"data0": [...]}
    my $str   = '';
    my $fmt   = '%24s | ';

    # title
    my $rowd = $data0->[0];
    foreach my $key ( keys %$rowd ) {
        if ( length($key) > 24 ) {
            $key = substr( $key, 0, 21 ) . '...';
        }
        $str .= sprintf( $fmt, $key );
    }
    $str .= "\n";

    foreach my $rowd (@$data0) {
        foreach my $val ( values %$rowd ) {
            if ( length($val) > 24 ) {
                $val = substr( $val, 0, 21 ) . '...';
            }
            $str .= sprintf( $fmt, $val );
        }
        $str .= "\n";
    }

    return $str;
}

sub render_static_file {
    my $c   = shift;
    my $ext = shift;

    # support for ext xxxx.yy
    my $format = $ext;
    if ( $ext =~ /\.(\w+)$/ ) {
        $format = $1;
    }

    my $path = $c->match->path_for->{path};
    $path =~ s/\.\w+$//;    # strippo l'eventuale estensione residua

    my $documentRoot =
      $c->app->config->{docs_root} ? $c->app->config->{docs_root} . '/' : '';

    my %opt = (
        content_disposition => 'inline',
        filepath => $c->app->home->rel_file("$documentRoot$path.$ext"),
        format   => $format,
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
