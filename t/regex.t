use v6;

use Test;
use Perl6::Parser;

plan 4;

my $pt = Perl6::Parser.new;
my $*VALIDATION-FAILURE-FATAL = True;
my $*FACTORY-FAILURE-FATAL = True;

subtest {
	plan 2;

	subtest {
		my $source = Q{/pi/};
		my $parsed = $pt.parse( $source );
		my $tree = $pt.build-tree( $parsed );
		ok $pt.validate( $parsed ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{no ws};

	subtest {
		plan 2;

		my $source = Q:to[_END_];
/pi/
_END_
		my $parsed = $pt.parse( $source );
		my $tree = $pt.build-tree( $parsed );
		ok $pt.validate( $parsed ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{ws};
}, Q{/pi/};

subtest {
	plan 2;

	subtest {
		plan 2;

		my $source = Q{/<[ p i ]>/};
		my $parsed = $pt.parse( $source );
		my $tree = $pt.build-tree( $parsed );
		ok $pt.validate( $parsed ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{no ws};

	subtest {
		plan 2;

		my $source = Q:to[_END_];
/ <[ p i ]> /
_END_
		my $parsed = $pt.parse( $source );
		my $tree = $pt.build-tree( $parsed );
		ok $pt.validate( $parsed ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{ws};
}, Q{/<[ p i ]>/};

subtest {
	plan 2;

	subtest {
		plan 2;

		my $source = Q{/\d/};
		my $parsed = $pt.parse( $source );
		my $tree = $pt.build-tree( $parsed );
		ok $pt.validate( $parsed ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{no ws};

	subtest {
		plan 2;

		my $source = Q:to[_END_];
/ \d /
_END_
		my $parsed = $pt.parse( $source );
		my $tree = $pt.build-tree( $parsed );
		ok $pt.validate( $parsed ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{ws};
}, Q{/ \d /};

subtest {
	plan 2;

	subtest {
		plan 2;

		my $source = Q{/./};
		my $parsed = $pt.parse( $source );
		my $tree = $pt.build-tree( $parsed );
		ok $pt.validate( $parsed ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{no ws};

	subtest {
		plan 2;

		my $source = Q:to[_END_];
/ . /
_END_
		my $parsed = $pt.parse( $source );
		my $tree = $pt.build-tree( $parsed );
		ok $pt.validate( $parsed ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{ws};
}, Q{/ . /};

# vim: ft=perl6
