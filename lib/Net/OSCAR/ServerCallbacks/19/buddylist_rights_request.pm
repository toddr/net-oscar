package Net::OSCAR::Callbacks;
use strict;
use warnings;
use vars qw($SESSIONS $SCREENNAMES %COOKIES $screenname $connection $snac $conntype $family $subtype $data $reqid $reqdata $session $protobit %data);
sub {

$connection->proto_send(protobit => "buddylist_3_response", reqid => $reqid);

};
