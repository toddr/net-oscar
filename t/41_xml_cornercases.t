#!/usr/bin/perl

use Test::More;
use File::Basename;
use strict;
use lib "./blib/lib";
no warnings;

my %do_tests = map {$_ => 1} @ARGV;

my @tests = grep {%do_tests ? exists($do_tests{$_->{template}}) : 1} (
	{
		binary => pack("nnn nnn", 1, 2, 3, 99, 2, 20),
		data => {x => 3, __UNKNOWN => [
			{type => 99, data => pack("n", 20)}
		]},
		template => "basic_tlv",
		decode => 1,
		name => "TLV extra data discard"
	},{
		binary => pack("nnn nnn nnn", 1, 2, 3, 99, 2, 20, 100, 2, 21),
		data => {x => 3, __UNKNOWN => [
			{type => 99, data => pack("n", 20)},
			{type => 100, data => pack("n", 21)}
		]},
		template => "basic_tlv",
		decode => 1,
		name => "TLV extra data discard multiple"
	},{
		binary => pack("nnn", 1, 2, 3),
		data => {x => 3},
		template => "basic_tlv",
		encode => 1,
		name => "TLV extra data suppress"
	}
);


plan(tests => 3+@tests);

require_ok("Net::OSCAR");
require_ok("Net::OSCAR::XML");
Net::OSCAR::XML->import('protoparse');

my $oscar = Net::OSCAR->new();
is(Net::OSCAR::XML::load_xml(dirname($0)."/test.xml"), 1, "loading XML test file");

$oscar->loglevel(99) if %do_tests;
foreach (@tests) {
	is(
		protoparse($oscar, $_->{template})->pack(%{$_->{data}}),
		$_->{binary},
		"Encode: " . (exists($_->{name}) ? $_->{name} : $_->{template})
	) if $_->{encode};

	is_deeply(
		{protoparse($oscar, $_->{template})->unpack($_->{binary})},
		$_->{data},
		"Decode: " . (exists($_->{name}) ? $_->{name} : $_->{template})
	) if $_->{decode};
}
