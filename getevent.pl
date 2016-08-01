#!/usr/bin/perl -w

use Data::Dumper;
#use EV;
use Asterisk::AMI;
my $astman = Asterisk::AMI->new(PeerAddr        =>        '127.0.0.1',
                                        PeerPort        =>        '5038',
                                        Username        =>        'megaadmin',
                                        Secret => 'Kasdflm223asdfmlasdf',
                                        Events => 'on',
                                        Handlers => { default => \&do_event,
							Hangup => \&do_hangup }
                                );

die "Unable to connect to asterisk" unless ($astman);

sub do_event {
                my ($asterisk, $event) = @_;

                print 'Yeah! Event Type: ' . $event->{'Event'} . "\r\n";
if ($event->{'Event'} eq "Registry") {
		 print Dumper($event);
}
        }

sub do_hangup {
                my ($asterisk, $event) = @_;
                print 'Channel ' . $event->{'Channel'} . ' Hungup because ' . $event->{'Cause-txt'} . "\r\n";
        }

        #Start some event loop
sleep 1;
#someloop;
#EV::loop
$astman->loop;
