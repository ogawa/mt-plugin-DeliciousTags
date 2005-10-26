# Movable Type plugin for displaying del.icio.us tags.
#
# $Id$
#
# This software is provided as-is. You may use it for commercial or 
# personal use. If you distribute it, please keep this notice intact.
#
# Copyright (c) 2005 Hirotaka Ogawa
#
package MT::Plugin::DeliciousTags;
use strict;
use base 'MT::Plugin';
use vars qw($VERSION);
$VERSION = '0.01';

use MT;
use MT::Template::Context;

my $plugin = MT::Plugin::DeliciousTags->new({
    name => 'Delicious Tags',
    description => "A plugin for importing and displaying your del.icio.us tags",
    doc_link => 'http://as-is.net/hacks/2005/10/delicious_tags_plugin.html',
    author_name => 'Hirotaka Ogawa',
    author_link => 'http://profile.typekey.com/ogawa/',
    version => $VERSION,
});
MT->add_plugin($plugin);
MT::Template::Context->add_container_tag(DeliciousTags => \&tags);
MT::Template::Context->add_container_tag(DeliciousTagsHeader => \&pass_tokens);
MT::Template::Context->add_container_tag(DeliciousTagsFooter => \&pass_tokens);
MT::Template::Context->add_tag(DeliciousTag => \&tag);
MT::Template::Context->add_tag(DeliciousTagURL => \&tag_url);
MT::Template::Context->add_tag(DeliciousTagCount => \&tag_count);

use Net::Delicious;

sub tags {
    my ($ctx, $args, $cond) = @_;
    my $user = $args->{user} || '';
    my $pass = $args->{pass} || '';
    return $ctx->error("'user' and 'pass' option must be specified")
	unless $user && $pass;
    $ctx->stash('DeliciousUser', $user);

    my $sort_by = $args->{sort_by} || 'tag';
    my $sort_order = $args->{sort_order} || 'ascend';
    my $lastn = $args->{lastn} || 0;

    my $del = Net::Delicious->new({ user => $user, pswd => $pass });
    my @tags = $del->tags();

    @tags = sort { $a->count() <=> $b->count() } @tags
	if $sort_by eq 'count';
    @tags = reverse @tags
	if $sort_order eq 'descend';

    my @res;
    my $builder = $ctx->stash('builder');
    my $tokens = $ctx->stash('tokens');
    my $i = 0;
    foreach (@tags) {
	last if $lastn && $i >= $lastn;
	local $ctx->{__stash}{'DeliciousTag'} = $_->tag();
	local $ctx->{__stash}{'DeliciousTagCount'} = $_->count();
	defined(my $out = $builder->build($ctx, $tokens, {
	    %$cond,
	    DeliciousTagsHeader => !$i,
	    DeliciousTagsFooter => !defined $tags[$i+1],
	}))
	    or return $ctx->error($ctx->errstr);
	push @res, $out;
	$i++;
    }
    my $glue = $args->{glue} || '';
    join $glue, @res;
}

sub pass_tokens {
    my ($ctx, $args, $cond) = @_;
    $ctx->stash('builder')->build($ctx, $ctx->stash('tokens'), $cond);
}

sub tag {
    $_[0]->stash('DeliciousTag') || '';
}

sub tag_url {
    my $user = $_[0]->stash('DeliciousUser');
    my $tag = $_[0]->stash('DeliciousTag');
    $user && $tag ? "http://del.icio.us/$user/$tag" : '';
}

sub tag_count {
    $_[0]->stash('DeliciousTagCount') || 0;
}

1;
__END__

=head1 NAME

DeliciousTags.pl - A simple Movable Type plugin for displaying your
del.icio.us tags.

=head1 DESCRIPTION

This plugin allows you to import your del.icio.us tags into your
MT blogs.

=head1 TAGS

=over 4

=item MTDeliciousTags [user="..."][pass="..."][sort_by="tag|count"][sort_order="ascend|descend][lastn="N"]

A container tag for your del.icio.us tags. "user" and "pass" are required.

=item MTDeliciousTag

Generates a del.icio.us tag.

=item MTDeliciousTagURL

Generates the URL to a del.icio.us (e.g., http://del.icio.us/user/tag).

=item MTDeliciousTagCount

Generates the number how many a del.icio.us tag appears in your
del.icio.us bookmarks.

=item MTDeliciousTagsHeader

A container tag that renders its contents before the first del.icio.us
tag.

=item MTDeliciousTagsFooter

A container tag that renders its contents after the last del.icio.us
tag.

=back

=head1 EXAMPLE

<MTDeliciousTags user="del.icio.us.username" pass="del.icio.us.password">
<MTDeliciousTagsHeader><ol></MTDeliciousTagsHeader>
<li><a href="<$MTDeliciousTagURL$>"><$MTDeliciousTag$></a>
  (<$MTDeliciousTagCount$>)</li>
<MTDeliciousTagsFooter></ol></MTDeliciousTagsFooter>
</MTDeliciousTags>

=head1 LICENSE

This code is released under the Artistic License. The terms of the
Artistic License are described at
L<http://www.perl.com/language/misc/Artistic.html>.

=head1 AUTHOR & COPYRIGHT

Copyright (c) 2005 Hirotaka Ogawa (hirotaka.ogawa at gmail.com)

=cut

=end
