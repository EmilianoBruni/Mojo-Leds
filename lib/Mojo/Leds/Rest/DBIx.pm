package Mojo::Leds::Rest::DBIx;

use Mojo::Base 'Mojo::Leds::Page';

has pk => 'id';

sub _create {
    my $c   = shift;
    my $rec = shift;
    $rec = $c->tableDB->create($rec);

    return $c->_raise_error( 'Element duplicated', 409 )
      unless ( $rec->in_storage );

    return $rec;
}

sub _rec2json() {
    my $c   = shift;
    my $rec = shift || $c->stash( $c->_class_name . '::record' );
    return { $rec->get_columns };
}

sub _patch {
    my $c   = shift;
    my $set = shift;

    # remove id from updated fields
    delete $set->{ $c->pk };

    my $rec = $c->stash( $c->_class_name . '::record' );
    return $c->_raise_error( 'Element not found', 404 )
      unless $rec;
    $rec = $rec->update($set);

    return $rec;
}

sub read {
    my $c   = shift;
    my $rec = $c->stash('restrec');
    $c->render_json( { $rec->get_columns } );
}

sub update {
    my $c = shift;
    return $c->_raise_error( "Resource is read-only", 403 ) if $c->ro;
    my $json = $c->_json_from_body;
    return unless ($json);
    my $id  = $c->param('id');
    my $rec = $c->_update( $id, $json );
    return unless ($rec);
    $c->render_json( { $rec->get_columns } );
}

sub _update {
    my $c    = shift;
    my $id   = shift;
    my $json = shift;

    # remove id from updated fields
    delete $json->{ $c->pk };

    my $rec = $c->stash('restrec');
    return $c->_raise_error( 'Element not found', 404 ) unless ($rec);
    $c->_sync_rec_with_json( $rec, $json );
    $rec->update;
    return $rec;
}

sub _delete {
    my $c   = shift;
    my $rec = shift;
    $rec->delete;
    return $rec;
}

sub list {
    my $c     = shift;
    my $query = $c->param('query');
    return $c->$query(@_) if ($query);

    my ( $qry, $opt, $with_count ) = $c->_qs2q;
    my $rec  = $c->_dbfind( $qry, $opt );
    my @recs = $rec->all;

    my $ret = [ $rec->hashref_array() ];
    if ($with_count) {
        $ret = [ { count => $rec->pager->total_entries }, recs => $ret ];
    }

    $c->render_json($ret);
}

sub listupdate {
    my $c = shift;
    return $c->_raise_error( "Resource is read-only", 403 ) if $c->ro;
    my $json = $c->_json_from_body;
    return unless ($json);

    # json deve essere un array
    return $c->_raise_error( 'Not an array of records', 422 )
      unless ( ref($json) eq 'ARRAY' );

    my @recs;

    foreach my $item (@$json) {
        my $rec = $c->db->resultset( $c->tableT )->update_or_create($item);
        push @recs, $c->_rec2json($rec);

    }

    $c->render_json( \@recs );
}

sub _qs2q {
    my $c   = shift;
    my $flt = $c->req->query_params->to_hash;
    my $qry = {};
    my $opt = {};
    my $rc  = 0;

    while ( my ( $k, $v ) = each %$flt ) {
        for ($k) {
            if (/^q\[(.*?)\]/) { $qry->{$1} = $v }

            # match regexp filter
            elsif (/^qre\[(.*?)\]/) {
            }
            elsif (/^sort\[(.*?)\]/) {
                my $order = $v == 1 ? '-asc' : '-desc';
                push @{ $opt->{order_by} }, { $order => $1 };
            }
            elsif ( $_ eq 'limit' ) { $opt->{rows} = $v }
            elsif ( $_ eq 'skip' )  { $opt->{rows} = $v }
            elsif ( $_ eq 'rc' )    { $rc          = $v }
            elsif ( $_ eq 'page' )  { $opt->{page} = $v }
        }
    }

    # # simple sort, needs sort and order
    # if ( defined $flt->{sort} && defined $flt->{order} ) {
    #     $opt->{sort}->Push( $flt->{sort} => $flt->{order} eq 'asc' ? -1 : 1 );
    # }
    $c->app->log->debug( 'Query url: '
          . Data::Dumper::Dumper($flt)
          . "\nDBIx search: "
          . Data::Dumper::Dumper($qry)
          . "\nDBIx opt: "
          . Data::Dumper::Dumper($opt) );

    return ( $qry, $opt, $rc );
}

sub _dbfind {
    my $c   = shift;
    my $qry = shift;
    my $opt = shift;

    return $c->db->resultset( $c->tableT )->search( $qry, $opt );
}

# sub sync_rec_with_post {
#     my $c   = shift;
#     my $rec = shift;
#     $c->app->log->debug( Data::Dumper::Dumper( $c->req->params->to_hash ) );
#     my %par = %{ $c->req->params->to_hash };
#     while ( my ( $k, $v ) = each %par ) {
#         unless ( $rec->$k && $v eq $rec->get_column($k) ) {
#             $c->app->log->debug(
#                 "$k was " . $rec->get_column($k) . " updated with $v" );
#             $rec->$k($v);
#         }
#     }
# }

sub _resource_lookup {
    my $c   = shift;
    my $id  = $c->restify->current_id;
    return $c->db->resultset( $c->tableT )->single( { $c->pk => $id } );
}

1;

__END__

# ABSTRACT: A RESTFul interface to Class::DBIx

=pod

=encoding UTF-8

=head1 SYNOPSIS

=head1 DESCRIPTION

=cut
