package Net::OSCAR::Common;

$VERSION = '0.62';

use strict;
use vars qw(@ISA @EXPORT_OK %EXPORT_TAGS $VERSION);
use Scalar::Util qw(dualvar);
use Net::OSCAR::TLV;
use Carp;
require Exporter;
@ISA = qw(Exporter);

%EXPORT_TAGS = (
	standard => [qw(
		ADMIN_TYPE_PASSWORD_CHANGE
		ADMIN_TYPE_EMAIL_CHANGE
		ADMIN_TYPE_SCREENNAME_FORMAT
		ADMIN_TYPE_ACCOUNT_CONFIRM
		ADMIN_ERROR_UNKNOWN
		ADMIN_ERROR_BADPASS
		ADMIN_ERROR_BADINPUT
		ADMIN_ERROR_BADLENGTH
		ADMIN_ERROR_TRYLATER
		ADMIN_ERROR_REQPENDING
		ADMIN_ERROR_CONNREF
		VISMODE_PERMITALL
		VISMODE_DENYALL
		VISMODE_PERMITSOME
		VISMODE_DENYSOME
		VISMODE_PERMITBUDS
		TYPINGSTATUS_STARTED
		TYPINGSTATUS_TYPING
		TYPINGSTATUS_FINISHED
		RATE_CLEAR
		RATE_ALERT
		RATE_LIMIT
		RATE_DISCONNECT
		GROUPPERM_OSCAR
		GROUPPERM_AOL
		OSCAR_SVC_AIM
		OSCAR_SVC_ICQ
	)],
	loglevels => [qw(
		OSCAR_DBG_NONE
		OSCAR_DBG_WARN
		OSCAR_DBG_INFO
		OSCAR_DBG_SIGNON
		OSCAR_DBG_NOTICE
		OSCAR_DBG_DEBUG
		OSCAR_DBG_PACKETS
	)],
	all => [qw(
		OSCAR_DBG_NONE OSCAR_DBG_WARN OSCAR_DBG_INFO OSCAR_DBG_SIGNON OSCAR_DBG_NOTICE OSCAR_DBG_DEBUG OSCAR_DBG_PACKETS
		ADMIN_TYPE_PASSWORD_CHANGE ADMIN_TYPE_EMAIL_CHANGE ADMIN_TYPE_SCREENNAME_FORMAT ADMIN_TYPE_ACCOUNT_CONFIRM
		ADMIN_ERROR_UNKNOWN ADMIN_ERROR_BADPASS ADMIN_ERROR_BADINPUT ADMIN_ERROR_BADLENGTH ADMIN_ERROR_TRYLATER ADMIN_ERROR_REQPENDING ADMIN_ERROR_CONNREF
		VISMODE_PERMITALL VISMODE_DENYALL VISMODE_PERMITSOME VISMODE_DENYSOME VISMODE_PERMITBUDS RATE_CLEAR RATE_ALERT RATE_LIMIT RATE_DISCONNECT
		TYPINGSTATUS_STARTED TYPINGSTATUS_TYPING TYPINGSTATUS_FINISHED
		FLAP_CHAN_NEWCONN FLAP_CHAN_SNAC FLAP_CHAN_ERR FLAP_CHAN_CLOSE
		CONNTYPE_LOGIN CONNTYPE_BOS CONNTYPE_ADMIN CONNTYPE_CHAT CONNTYPE_CHATNAV CONNTYPE_ICON
		MODBL_ACTION_ADD MODBL_ACTION_DEL MODBL_WHAT_BUDDY MODBL_WHAT_GROUP MODBL_WHAT_PERMIT MODBL_WHAT_DENY
		GROUPPERM_OSCAR GROUPPERM_AOL OSCAR_SVC_AIM OSCAR_SVC_ICQ
		OSCAR_CAPS OSCAR_TOOLDATA
		BUDTYPES
		ENCODING
		ERRORS
		randchars log_print log_printf hexdump normalize tlv_decode tlv_encode tlv send_error bltie signon_tlv encode_password
	)]
);
@EXPORT_OK = map { @$_ } values %EXPORT_TAGS;


sub tlv(;@) {
	my %tlv = ();
	tie %tlv, "Net::OSCAR::TLV";
	while(@_) { my($key, $value) = (shift, shift); $tlv{$key} = $value; }
	return \%tlv;
}


use constant OSCAR_DBG_NONE => 0;
use constant OSCAR_DBG_WARN => 1;
use constant OSCAR_DBG_INFO => 2;
use constant OSCAR_DBG_SIGNON => 3;
use constant OSCAR_DBG_NOTICE => 4;
use constant OSCAR_DBG_DEBUG => 6;
use constant OSCAR_DBG_PACKETS => 10;

use constant TYPINGSTATUS_STARTED => dualvar(2, "typing started");
use constant TYPINGSTATUS_TYPING => dualvar(1, "typing in progress");
use constant TYPINGSTATUS_FINISHED => dualvar(0, "typing completed");

use constant ADMIN_TYPE_PASSWORD_CHANGE => dualvar(1, "password change");
use constant ADMIN_TYPE_EMAIL_CHANGE => dualvar(2, "email change");
use constant ADMIN_TYPE_SCREENNAME_FORMAT => dualvar(3, "screenname format");
use constant ADMIN_TYPE_ACCOUNT_CONFIRM => dualvar(4, "account confirm");

use constant ADMIN_ERROR_UNKNOWN => dualvar(0, "unknown error");
use constant ADMIN_ERROR_BADPASS => dualvar(1, "incorrect password");
use constant ADMIN_ERROR_BADINPUT => dualvar(2, "invalid input");
use constant ADMIN_ERROR_BADLENGTH => dualvar(3, "screenname/email/password is too long or too short");
use constant ADMIN_ERROR_TRYLATER => dualvar(4, "request could not be processed; wait a few minutes and try again");
use constant ADMIN_ERROR_REQPENDING => dualvar(5, "request pending");
use constant ADMIN_ERROR_CONNREF => dualvar(6, "couldn't connect to the admin server");

use constant FLAP_CHAN_NEWCONN => dualvar(0x01, "new connection");
use constant FLAP_CHAN_SNAC => dualvar(0x02, "SNAC");
use constant FLAP_CHAN_ERR => dualvar(0x03, "error");
use constant FLAP_CHAN_CLOSE => dualvar(0x04, "close connection");

use constant CONNTYPE_LOGIN => dualvar(0, "login service");
use constant CONNTYPE_BOS => dualvar(0x2, "basic OSCAR services");
use constant CONNTYPE_ADMIN => dualvar(0x7, "administrative service");
use constant CONNTYPE_CHAT => dualvar(0xE, "chat connection");
use constant CONNTYPE_CHATNAV => dualvar(0xD, "chat navigator");
use constant CONNTYPE_ICON => dualvar(0x10, "icon service");

use constant MODBL_ACTION_ADD => 0x1;
use constant MODBL_ACTION_DEL => 0x2;

use constant MODBL_WHAT_BUDDY => 0x1;
use constant MODBL_WHAT_GROUP => 0x2;
use constant MODBL_WHAT_PERMIT => 0x3;
use constant MODBL_WHAT_DENY => 0x4;

use constant VISMODE_PERMITALL  => dualvar(0x1, "permit all");
use constant VISMODE_DENYALL    => dualvar(0x2, "deny all");
use constant VISMODE_PERMITSOME => dualvar(0x3, "permit some");
use constant VISMODE_DENYSOME   => dualvar(0x4, "deny some");
use constant VISMODE_PERMITBUDS => dualvar(0x5, "permit buddies");

use constant GROUP_PERMIT => 0x0002;
use constant GROUP_DENY   => 0x0003;

use constant RATE_CLEAR => dualvar(1, "clear");
use constant RATE_ALERT => dualvar(2, "alert");
use constant RATE_LIMIT => dualvar(3, "limit");
use constant RATE_DISCONNECT => dualvar(4, "disconnect");

use constant GROUPPERM_OSCAR => dualvar(0x18, "AOL Instant Messenger users");
use constant GROUPPERM_AOL => dualvar(0x04, "AOL subscribers");

use constant OSCAR_SVC_AIM => (
	host => 'login.oscar.aol.com',
	port => 5190,
	supermajor => 0x0109,
	major => 5,
	minor => 1,
	subminor => 0,
	build => 3292,
	subbuild => 0xEE,
	clistr => "AOL Instant Messenger, version 5.2.3292/WIN32",
	hashlogin => 0,
	betainfo => "",
);
use constant OSCAR_SVC_ICQ => ( # Courtesy of SDiZ Cheng
	host => 'login.icq.com',
	port => 5190,
	supermajor => 0x010A,
	major => 5,
	minor => 0x2D,
	subminor => 0,
	build => 0xEC1,
	subbuild => 0x55,
	clistr => "ICQ Inc. - Product of ICQ (TM).2003a.5.45.1.3777.85",
	hashlogin => 1,
);	

use constant OSCAR_CAPS => {
	chat => {description => "chatrooms", value => pack("C*", map{hex($_)} split(/[ \t\n]+/,
		"0x74 0x8F 0x24 0x20 0x62 0x87 0x11 0xD1 0x82 0x22 0x44 0x45 0x53 0x54 0x00 0x00"))},
	interoperate => {description => "ICQ/AIM interoperation", value => pack("C*", map{hex($_)} split(/[ \t\n]+/,
		"0x09 0x46 0x13 0x4d 0x4c 0x7f 0x11 0xd1 0x82 0x22 0x44 0x45 0x53 0x54 0x00 0x00"))},
	extstatus => {description => "iChat extended status messages", value => pack("C*", map{hex($_)} split(/[ \t\n]+/,
		"0x09 0x46 0x00 0x00 0x4c 0x7f 0x11 0xd1 0x82 0x22 0x44 0x45 0x53 0x54 0x00 0x00"))},
	buddyicon => {description => "buddy icons", value => pack("C*", map{hex($_)} split(/[ \t\n]+/,
		"0x09 0x46 0x13 0x46 0x4c 0x7f 0x11 0xd1 0x82 0x22 0x44 0x45 0x53 0x54 0x00 0x00"))},
	getfile => {description => "receiving file transfers", value => pack("C*", map{hex($_)} split(/[ \t\n]+/,
		"0x09 0x46 0x13 0x48 0x4c 0x7f 0x11 0xd1 0x82 0x22 0x44 0x45 0x53 0x54 0x00 0x00"))},
	sendfile => {description => "sending file transfers", value => pack("C*", map{hex($_)} split(/[ \t\n]+/,
		"0x09 0x46 0x13 0x43 0x4c 0x7f 0x11 0xd1 0x82 0x22 0x44 0x45 0x53 0x54 0x00 0x00"))},
        secureim => {description => "encrypted IM", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x00, 0x01, 0x4c, 0x7f, 0x11, 0xd1, 0x82, 0x22, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	hiptop => {description => "hiptop", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x13, 0x23, 0x4c, 0x7f, 0x11, 0xd1, 0x82, 0x22, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	voice => {description => "voice chat", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x13, 0x41, 0x4c, 0x7f, 0x11, 0xd1, 0x82, 0x22, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	icq => {description => "EveryBuddy ICQ support", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x13, 0x44, 0x4c, 0x7f, 0x11, 0xd1, 0x82, 0x22, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	directim => {description => "direct IM", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x13, 0x45, 0x4c, 0x7f, 0x11, 0xd1, 0x82, 0x22, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	addins => {description => "add-ins", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x13, 0x47, 0x4c, 0x7f, 0x11, 0xd1, 0x82, 0x22, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	icqrelay => {description => "ICQ server relay", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x13, 0x49, 0x4c, 0x7f, 0x11, 0xd1, 0x82, 0x22, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	games => {description => "games", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x13, 0x4a, 0x4c, 0x7f, 0x11, 0xd1, 0x82, 0x22, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	games2 => {description => "games 2", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x13, 0x4a, 0x4c, 0x7f, 0x11, 0xd1, 0x22, 0x82, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	sendlist => {description => "buddy list sending", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x13, 0x4b, 0x4c, 0x7f, 0x11, 0xd1, 0x82, 0x22, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	icqutf8 => {description => "ICQ UTF-8", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09, 0x46, 0x13, 0x4e, 0x4c, 0x7f, 0x11, 0xd1, 0x82, 0x22, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00"))},
	icqutf8old => {description => "old ICQ UTF-8", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x2e, 0x7a, 0x64, 0x75, 0xfa, 0xdf, 0x4d, 0xc8, 0x88, 0x6f, 0xea, 0x35, 0x95, 0xfd, 0xb6, 0xdf"))},
	icqrtf => {description => "ICQ RTF", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x97, 0xb1, 0x27, 0x51, 0x24, 0x3c, 0x43, 0x34, 0xad, 0x22, 0xd6, 0xab, 0xf7, 0x3f, 0x14, 0x92"))},
	apinfo => {description => "AP info", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0xaa, 0x4a, 0x32, 0xb5, 0xf8, 0x84, 0x48, 0xc6, 0xa3, 0xd7, 0x8c, 0x50, 0x97, 0x19, 0xfd, 0x5b"))},
	trilliancrypt => {description => "Trillian encryption", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0xf2, 0xe7, 0xc7, 0xf4, 0xfe, 0xad, 0x4d, 0xfb, 0xb2, 0x35, 0x36, 0x79, 0x8b, 0xdf, 0x00, 0x00"))},
	sms => {description => "SMS sending", value => pack("C*", map{hex($_)} split(/[ \t\n,]+/,
		"0x09 0x46 0x01 0xff 0x4c 0x7f 0x11 0xd1 0x82 0x22 0x44 0x45 0x53 0x54 0x00 0x00"))},
};

use constant OSCAR_TOOLDATA => tlv(
	0x0001 => {version => 0x0003, toolid => 0x0110, toolversion => 0x0739},
	0x0013 => {version => 0x0003, toolid => 0x0110, toolversion => 0x0739},
	0x0002 => {version => 0x0001, toolid => 0x0110, toolversion => 0x0739},
	0x0003 => {version => 0x0001, toolid => 0x0110, toolversion => 0x0739},
	0x0004 => {version => 0x0001, toolid => 0x0110, toolversion => 0x0739},
	0x0005 => {version => 0x0001, toolid => 0x0001, toolversion => 0x0001, nobos => 1},
	0x0006 => {version => 0x0001, toolid => 0x0110, toolversion => 0x0739},
	0x0007 => {version => 0x0001, toolid => 0x0010, toolversion => 0x0739, nobos => 1},
	0x0008 => {version => 0x0001, toolid => 0x0104, toolversion => 0x0001},
	0x0009 => {version => 0x0001, toolid => 0x0110, toolversion => 0x0739},
	0x000A => {version => 0x0001, toolid => 0x0110, toolversion => 0x0739},
	0x000B => {version => 0x0001, toolid => 0x0104, toolversion => 0x0001},
	0x000C => {version => 0x0001, toolid => 0x0104, toolversion => 0x0001, nobos => 1},
	0x000D => {version => 0x0001, toolid => 0x0010, toolversion => 0x0739, nobos => 1},
	0x000E => {version => 0x0001, toolid => 0x0010, toolversion => 0x0739, nobos => 1},
	0x000F => {version => 0x0001, toolid => 0x0010, toolversion => 0x0739, nobos => 1},
	0x0010 => {version => 0x0001, toolid => 0x0010, toolversion => 0x0739, nobos => 1},
	0x0015 => {version => 0x0001, toolid => 0x0110, toolversion => 0x047C, nobos => 1},
	0x0017 => {version => 0x0000, toolid => 0x0000, toolversion => 0x0000, nobos => 1},
	0x0018 => {version => 0x0001, toolid => 0x0010, toolversion => 0x0739, nobos => 1},
	0xFFFF => {version => 0x0000, toolid => 0x0000, toolversion => 0x0000, nobos => 1},
);

use constant BUDTYPES => ("buddy", "group", "permit entry", "deny entry", "visibility/misc. data", "presence", "unknown 6", "unknown 7", "unknown 8", "unknown 9", "unknown 10", "unknown 11", "unknown 12", "unknown 13", "unknown 14", "unknown 15", "unknown 16", "unknown 17", "unknown 18", "unknown 19", "buddy icon data");

use constant ENCODING => 'text/aolrtf; charset="us-ascii"';

use constant ERRORS => split(/\n/, <<EOF);
Invalid error
Invalid SNAC
Sending too fast to host
Sending too fast to client
%s is not logged in, so the attempted operation (sending an IM, getting user information) was unsuccessful
Service unavailable
Service not defined
Obsolete SNAC
Not supported by host
Not supported by client
Refused by client
Reply too big
Responses lost
Request denied
Busted SNAC payload
Insufficient rights
%s is in your permit or deny list
Too evil (sender)
Too evil (receiver)
User temporarily unavailable
No match
List overflow
Request ambiguous
Queue full
Not while on AOL
Unknown error 25
Unknown error 26
Unknown error 27
Unknown error 28
There have been too many recent signons from this address.  Please wait a few minutes and try again.
EOF

sub randchars($) {
	my $count = shift;
	my $retval = "";
	for(my $i = 0; $i < $count; $i++) { $retval .= chr(int(rand(256))); }
	return $retval;
}

sub log_print($$@) {
	my($obj, $level) = (shift, shift);
	my $session = exists($obj->{session}) ? $obj->{session} : $obj;
	return unless defined($session->{LOGLEVEL}) and $session->{LOGLEVEL} >= $level;

	my $message = "";
	$message .= $obj->{description}. ": " if $obj->{description};
	$message .= join("", @_). "\n";

	if($session->{callbacks}->{log}) {
		$session->callback_log($level, $message);
	} else {
		$message = "(".$session->{screenname}.") $message" if $session->{SNDEBUG};
		print STDERR $message;
	}
}

sub log_printf($$$@) {
	my($obj, $level, $fmtstr) = (shift, shift, shift);

	$obj->log_print($level, sprintf($fmtstr, @_));
}

sub hexdump($) {
	my $stuff = shift;
	my $retbuff = "";
	my @stuff;

	for(my $i = 0; $i < length($stuff); $i++) {
		push @stuff, substr($stuff, $i, 1);
	}

	return $stuff unless grep { $_ lt chr(0x20) or $_ gt chr(0x7E) } @stuff;
	while(@stuff) {
		my $i = 0;
		$retbuff .= "\n\t";
		my @currstuff = splice(@stuff, 0, 16);

		foreach my $currstuff(@currstuff) {
			$retbuff .= " " unless $i % 4;
			$retbuff .= " " unless $i % 8;
			$retbuff .= sprintf "%02X ", ord($currstuff);
			$i++;
		}
		for(; $i < 16; $i++) {
			$retbuff .= " " unless $i % 4;
			$retbuff .= " " unless $i % 8;
			$retbuff .= "   ";
		}

		$retbuff .= "  ";
		$i = 0;
		foreach my $currstuff(@currstuff) {
			$retbuff .= " " unless $i % 4;
			$retbuff .= " " unless $i % 8;
			if($currstuff ge chr(0x20) and $currstuff le chr(0x7E)) {
				$retbuff .= $currstuff;
			} else {
				$retbuff .= ".";
			}
			$i++;
		}
	}
	return $retbuff;
}

sub normalize($) {
	my $temp = shift;
	$temp =~ tr/ //d if $temp;
	return $temp ? lc($temp) : "";
}

sub tlv_decode($;$) {
	my($tlv, $tlvcnt) = @_;
	my($type, $len, $value, %retval);
	my $currtlv = 0;
	my $strpos = 0;

	my $retval = tlv;

	$tlvcnt = 0 unless $tlvcnt;
	while(length($tlv) >= 4 and (!$tlvcnt or $currtlv < $tlvcnt)) {
		($type, $len) = unpack("nn", $tlv);
		$len = 0x2 if $type == 0x13;
		$strpos += 4;
		substr($tlv, 0, 4) = "";
		if($len) {
			($value) = substr($tlv, 0, $len, "");
		} else {
			$value = "";
		}
		$strpos += $len;
		$currtlv++ unless $type == 0;
		$retval->{$type} = $value;
	}

	return $tlvcnt ? ($retval, $strpos) : $retval;
}

sub tlv_encode($) {
	my $tlv = shift;
	my($buffer, $type, $value) = ("", 0, "");

	confess "You must use a tied Net::OSCAR::TLV hash!" unless defined($tlv) and ref($tlv) eq "HASH" and defined(%$tlv) and tied(%$tlv)->isa("Net::OSCAR::TLV");
	while (($type, $value) = each %$tlv) {
		$value ||= "";
		$buffer .= pack("nna*", $type, length($value), $value);

	}
	return $buffer;
}

sub send_error($$$$$;@) {
	my($oscar, $connection, $error, $desc, $fatal, @reqdata) = @_;
	$desc = sprintf $desc, @reqdata;
	$oscar->callback_error($connection, $error, $desc, $fatal);
}

sub bltie(;$) {
	my $retval = {};
	tie %$retval, "Net::OSCAR::Buddylist", @_;
	return $retval;
}

sub signon_tlv($;$$) {
	my($session, $password, $key) = @_;

	my $tlv = tlv(
		0x01 => $session->{screenname},
		0x03 => $session->{svcdata}->{clistr},
		0x16 => pack("n", $session->{svcdata}->{supermajor}),
		0x17 => pack("n", $session->{svcdata}->{major}),
		0x18 => pack("n", $session->{svcdata}->{minor}),
		0x19 => pack("n", $session->{svcdata}->{subminor}),
		0x1A => pack("n", $session->{svcdata}->{build}),
		0x14 => pack("N", $session->{svcdata}->{subbuild}),
		0x0F => "en", # lang
		0x0E => "us", # country
		0x4A => pack("C", 1), # Use SSI
	);

	if($session->{svcdata}->{hashlogin}) {
		$tlv->{0x02} = encode_password($session, $password);
	} else {
		if($session->{auth_response}) {
			($tlv->{0x25}) = delete $session->{auth_response};
		} else {
			$tlv->{0x25} = encode_password($session, $password, $key);
		}
		$tlv->{0x4A} = pack("C", 1);

		if($session->{svcdata}->{betainfo}) {
			$tlv->{0x4C} = $session->{svcinfo}->{betainfo};
		}
	}

	return $tlv;
}

sub encode_password($$;$) {
	my($session, $password, $key) = @_;

	if(!$session->{svcdata}->{hashlogin}) { # Use new SNAC-based method
		my $md5 = Digest::MD5->new;

		$md5->add($key);
		$md5->add($password);
		$md5->add("AOL Instant Messenger (SM)");
		return $md5->digest();
	} else { # Use old roasting method.  Courtesy of SDiZ Cheng.
		my $ret = "";
		my @pass = map {ord($_)} split(//, $password);

		my @encoding_table = map {hex($_)} qw(
			F3 26 81 C4 39 86 DB 92 71 A3 B9 E6 53 7A 95 7C
		);

		for(my $i = 0; $i < length($password); $i++) {
			$ret .= chr($pass[$i] ^ $encoding_table[$i]);
		}

		return $ret;
	}
}

1;
