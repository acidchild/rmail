#!/usr/bin/env perl
# Ash Palmer Sat Mar 20 17:11:01 EDT 2010
# ash@7a69.co.uk
#
use warnings;
use strict;

use Email::Sender::Transport::SMTP::TLS;
use Email::Simple::Creator;
use File::Slurp qw( slurp );
use Getopt::Long;
Getopt::Long::Configure('no_auto_abbrev');
use AppConfig;

my $force;
my $results = GetOptions( 'f' => \$force );

my $config = AppConfig->new( \%cfg );
$config->file("~/.rmailrc");

my @contacts = slurp($ARGV[0]);


my ($firstname, $lastname) = split(' ', $username, 2);







for my $contact (@contacts) {
	my $cmessage = slurp($emailbody);

	print "Sending Email to $name \@ $email\n";

	if ($force) {
		mailsend($contact, $cmessage);
	}
}



sub mailsend {
	my $to = shift;
	my $body = shift;
	my $sender = Email::Sender::Transport::SMTP::TLS->new(
		host => $host,
		port => 587,
		username => $username,
		password => $password,
		helo => '7a69.co.uk',
	);
    
	my $message = Email::Simple->create(
		header => [
			From    => "$firstname $lastname \<$emailaddr\>",
			To      => "$to",
			Subject => "$subject",
		],
		body => $body,
	);
    
	eval {
		$sender->send($message, {
			from => [ "$emailaddr" ],
			to   => [ "$to" ],
		} );
	};
	return 1;
}
