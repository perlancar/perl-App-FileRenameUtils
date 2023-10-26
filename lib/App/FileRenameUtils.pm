package App::FileRenameUtils;

use 5.010001;
use strict;
use warnings;

use Exporter 'import';

# AUTHORITY
# DATE
# DIST
# VERSION

our @EXPORT_OK = qw(add_filename_suffix find_unique_filename);

sub add_filename_suffix {
    no warnings 'uninitialized';

    my ($filename, $suffix) = @_;
    $filename =~ s/(.+?)(\.\w+)?\z/$1 . $suffix . $2/e;
    $filename;
}

sub find_unique_filename {
    my $filename = shift;

    my $orig_filename = $filename;
    my $i = 0;
    while (-e $filename) {
        $i++;
        $filename = add_filename_suffix($orig_filename, " ($i)");
    }
    $filename;
}

1;
#ABSTRACT: Utilities related to renaming/moving files

=head1 DESCRIPTION

This distribution provides the following command-line utilities:

# INSERT_EXECS_LIST


=head1 FUNCTIONS

=head2 add_filename_suffix

Usage:

 $new_name = add_filename_suffix($filename, $suffix);

Examples:

 add_filename_suffix("foo.jpg", " (1)"); # -> "foo (1).jpg"
 add_filename_suffix("foo", " (1)"); # -> "foo (1)"

=head2 find_unique_filename

Usage:

 $new_name = find_unique_filename($filename);

Continue adding suffix " (1)", " (2)", and so on to C<$filename> (see
L</add_filename_suffix>) until the new name does not exist on the filesystem. If
C<$filename> already does not exist, it will be returned as-is.


=head1 SEE ALSO

L<rename> from L<File::Rename>

L<perlmv> from L<App::perlmv>, and its various scriptlets under
C<App::perlmv::scriptlet::*>, e.g. L<App::perlmv::scriptlet::add_prefix> or
L<App::perlmv::scriptlet::according_to_containing_dir>.

L<renwd> from L<App::renwd>

Other similar distributions: L<App::FileModifyUtils>,
L<App::FileRemoveUtilities>.

=cut
