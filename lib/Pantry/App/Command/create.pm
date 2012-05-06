use v5.14;
use warnings;

package Pantry::App::Command::create;
# ABSTRACT: Implements pantry create subcommand
# VERSION

use Pantry::App -command;
use autodie;

use namespace::clean;

sub abstract {
  return 'Create items in a pantry (nodes, roles, etc.)';
}

sub command_type {
  return 'CREATE';
}

sub valid_types {
  return qw/node role/
}

sub _create_node {
  my ($self, $opt, $name) = @_;

  my $node = $self->pantry->node( $name );
  if ( -e $node->path ) {
    $self->usage_error( "Node '$name' already exists" );
  }
  else {
    $node->save;
  }

  return;
}

sub _create_role {
  my ($self, $opt, $name) = @_;

  my $role = $self->pantry->role( $name );
  if ( -e $role->path ) {
    $self->usage_error( "Role '$name' already exists" );
  }
  else {
    $role->save;
  }

  return;
}

1;

=for Pod::Coverage options validate

=head1 SYNOPSIS

  $ pantry create node foo.example.com

=head1 DESCRIPTION

This class implements the C<pantry create> command, which is used to create a new node data file
in a pantry.

=cut

# vim: ts=2 sts=2 sw=2 et:
