#!/usr/bin/perl 

use strict;
use warnings;

use JSON;
use CGI;
use DBI;
use Sys::Syslog;
# use Broker;
use Encode qw/decode/;
use File::Basename;
use MIME::Parser;
use File::Copy;
use File::Glob;
use File::Path;

my $q = CGI->new;
print $q->header('application/json');
my $json = JSON->new;
my @mailBody =();
my @mailText =();

openlog("--Show one quamail...  :");

my $db = DBI->connect("dbi:Pg:host=/tmp", "postgres", undef, {AutoCommit
=> 0});

if(!defined($db)) {
    print("error","Could not connect to Postgres db");
}

sub dump_entity {
    my ($entity, $name) = @_;
    defined($name) or $name = "'anonymous'";
    my $IO;

# Output the body:
    my @parts = $entity->parts;
    if (@parts) {                     # multipart...
        my $i;
        foreach $i (0 .. $#parts) {       # dump each part...
            dump_entity($parts[$i], ("$name, part ".(1+$i)));
        }
    }
    else {                            # single part...    

# Get MIME type, and display accordingly...
        my $type = $entity->head->mime_type;
        my $body = $entity->bodyhandle;
        if ($type =~ /text\/html/) {     
            if ($IO = $body->open("r")) {
                while (defined($_ = $IO->getline)) {
                    push @mailText, $_; 
                }
                $IO->close;
            }
            else {       # d'oh!
                print "$0: couldn't find/open '$name': $!";
            }
        } elsif ($type =~ /text\/plain/) {   
            push @mailText, "<pre>";
            if ($IO = $body->open("r")) {
                while (defined($_ = $IO->getline)) {
                    push @mailText, $_; 
                }
                push @mailText, "</pre>"; 
                $IO->close;
            }
            else {       # d'oh!
                print "$0: couldn't find/open '$name': $!";
            }

        } else {                                 # binary: just summarize it...
            my $path = $body->path;
            my $size = ($path ? (-s $path) : '???');

            my $f = basename($path);

            push @mailBody, "<p>Attached <a href=\"/$path\">$f<a> Size::
$size bytes </p>";
        }
    }
    1;
}

my $id = $q->param('id');

my $stmt = "select envip,mailfile,headers,subject,size,fromid,toid,date
from quamail where id = $id";

my @row = $db->selectrow_array($stmt);
my ($envip,$mailfile, $headers, $sub, $size, $from , $to, $date) = @row;

push @mailBody, "<strong>From</strong>: $from<br/>";
push @mailBody, "<strong>To</strong>: $to<br/>";
push @mailBody, "<strong>Date</strong>: $date<br/>";
push @mailBody, "<strong>Subject</strong>: $sub<br/>";

push @mailBody, "<br/>";

my $mfile = "/quamail/$mailfile";
my $parser = MIME::Parser->new;
$parser->output_under("/tmp");
my $entity = $parser->parse_open($mfile);

push @mailBody, "<br/>";
dump_entity($entity);
push @mailBody, "<br/>";
push @mailBody, @mailText;

my $h = {'mailBody' => [@mailBody]};
print($json->pretty->encode($h));
my @delfiles=</tmp/msg*>;
my $ign = rmtree(@delfiles, {verbose => 0});

