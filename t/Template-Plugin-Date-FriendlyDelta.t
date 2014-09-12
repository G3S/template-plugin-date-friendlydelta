# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Template-Plugin-FriendlyDelta.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use DateTime;

use Test::More tests => 7;
BEGIN { use_ok('Template::Plugin::Date::FriendlyDelta') };

my $test_date = DateTime->now()->datetime();
my $test_date_past = DateTime->now()->subtract(hours => 4);

is(Template::Plugin::Date::FriendlyDelta->filter($test_date), '1 minute ago', 'just a date');
is(Template::Plugin::Date::FriendlyDelta->filter($test_date_past), '4 hours ago', 'a date in the past');
is(Template::Plugin::Date::FriendlyDelta->filter('2012-08-11T12:00:00'), '11 August 2012', 'a date far in the past');

my $format_hash = {
	month => {
		1  => 'January',
		2  => 'February',
		3  => 'March',
		4  => 'April',
		5  => 'May',
		6  => 'June',
		7  => 'July',
		8  => 'août',
		9  => 'September',
		10  => 'October',
		11  => 'November',
		12  => 'December'
	},
	unit => {
		m   => 'minute',
		h   => 'aeon',
		d   => 'day',
	},
	return_format      => '$quantity $duration far gone'
};

is(Template::Plugin::Date::FriendlyDelta->filter($test_date, [$format_hash]), '1 minute far gone', 'just a date');
is(Template::Plugin::Date::FriendlyDelta->filter($test_date_past, [$format_hash]), '4 aeons far gone', 'a date in the past');
is(Template::Plugin::Date::FriendlyDelta->filter('2012-08-11T12:00:00', [$format_hash]), '11 août 2012', 'a date far in the past');

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

