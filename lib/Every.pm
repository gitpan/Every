package Every;
use strict;

use Exporter;
use vars qw( $VERSION @EXPORT_OK @EXPORT @ISA);
@EXPORT_OK = qw( &every );
@EXPORT = @EXPORT_OK;
$VERSION = 0.01;
@ISA = qw(Exporter);

{
 my %counters;
 my %time_counters;
 sub every
 {
  my ($div, @id) = @_;

  if ($div eq 'seconds')
  {
   $div = shift @id;			# the seconds will follow the 'seconds' string

   $time_counters{caller(), $div, @id} ||= time;

   my $then = $time_counters{caller(), $div, @id};
   my $diff = time - ($then + $div);
   return ($diff >= 0) ? ($time_counters{caller(), $div, @id} = time) : 0;
  }

  return !(++$counters{ caller(), $div, @id } % $div);
 }
}

1;

__END__

=pod

=head1 NAME

Every - return true every N cycles or S seconds

=head1 SYNOPSIS

 for (0..200)
 {
  print_stats() if every(20);		# every 20 cycles
  print_times() if every(seconds => 5); # every 5 or more seconds
  sleep 3;
 }

=head1 FUNCTION-ORIENTED INTERFACE

=head2 every( $number [, @id] )

=head2 every( seconds => $number [, @id] )

 Returns true every $number times it's called, or every time $number
 seconds have elapsed since the last time it was called.

 The every() function keeps track of where it was called by line.  If
 you need to call it twice on the same line, e.g.

 print "hello" if every(5) or every(6);

 That won't work.  The right way is to use an identifier, e.g.

 print "hello" if every(5, "a") or every(6, "b");

 The reason is that caller() doesn't return a position, only a line
 number.

=head1 DESCRIPTION

 Returns true when the conditions (cycles or seconds elapsed) are met.

 Thanks to Dr.Ruud on comp.lang.perl.misc for helping with this idea.

=head1 BUGS

 None known.

=head1 COPYRIGHT

Copyright 2008, Ted Zlatanov (Теодор Златанов). All Rights
Reserved. This module can be redistributed under the same terms as
Perl itself.

=head1 AUTHOR

Ted Zlatanov <tzz@lifelogs.com>

=head1 SEE ALSO


