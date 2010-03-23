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

# your fullname i.e. 'Ash Palmer'
my $fullname = '';
# your email address
my $emailaddr = '';
# your email username i.e. 'ash@7a69.co.uk' (i run postfix)
my $username = '';
# your email password
my $password = '';
# your SMTP host i.e. 'mail.example.org'
my $host = '';
# your email subject i.e ' Seeking employment ' 
my $subject = '';
# your email body i.e. cover letter 
my $emailbody = '';

my ($firstname, $lastname) = split(' ', $username, 2);


my $force;
my $results = GetOptions( 'f' => \$force );

my @contacts = slurp($ARGV[0]);

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
			Subject => "Seeking Career Opportunity",
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
