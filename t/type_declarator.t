use v6;

use Test;
use Perl6::Tidy;

#`(

In passing, please note that while it's trivially possible to bum down the
tests, doing so makes it harder to insert 'say $p.dump' to view the
AST, and 'say $tree.perl' to view the generated Perl 6 structure.

)

#`(

As much as I dislike explicitly handling whitespace, here's the rationale:

Leading WS, intrabrace WS and trailing WS are all different lengths. This is
by design, so that in case I've matched the wrong whitespace section (they all
look alike) during testing, the different lengths will break the test.

Leading is 5 characters, intra is 3, trailing is 2.
It's a happy coincidence that these are the 3rd-5th terms in the Fibonacci
sequence.

It's not a coincidence, however, that leading, trailing and intrabrace spacing
all get tested in the same file, however.

)

#`(

The terms that get tested here are:

enum <name> "foo"
subset <name> of Type
constant <name> = 1
	
)

plan 3;

my $pt = Perl6::Tidy.new;
#my $*TRACE = 1;
#my $*DEBUG = 1;

subtest {
	plan 2;

	subtest {
		plan 4;

		subtest {
			plan 2;

			my $source = Q:to[_END_];
enum Foo()
_END_
			my $p = $pt.parse-source( $source );
			my $tree = $pt.build-tree( $p );
			ok $pt.validate( $p ), Q{valid};
			is $pt.format( $tree ), $source, Q{formatted};
		}, Q{no ws};

		subtest {
			plan 2;

			my $source = Q:to[_END_];
enum Foo     ()
_END_
			my $p = $pt.parse-source( $source );
			my $tree = $pt.build-tree( $p );
			ok $pt.validate( $p ), Q{valid};
			is $pt.format( $tree ), $source, Q{formatted};
		}, Q{leading ws};

		subtest {
			plan 2;

			my $source = Q{enum Foo()  };
			my $p = $pt.parse-source( $source );
			my $tree = $pt.build-tree( $p );
			ok $pt.validate( $p ), Q{valid};
			is $pt.format( $tree ), $source, Q{formatted};
		}, Q{trailing ws};

		subtest {
			plan 2;

			my $source = Q{enum Foo     ()  };
			my $p = $pt.parse-source( $source );
			my $tree = $pt.build-tree( $p );
			ok $pt.validate( $p ), Q{valid};
			is $pt.format( $tree ), $source, Q{formatted};
		}, Q{leading, trailing ws};
	}, Q{no intrabrace spacing};

	subtest {
		plan 4;

		subtest {
			plan 0;

#`(
			my $source = Q:to[_END_];
enum Foo(   )
_END_
			my $p = $pt.parse-source( $source );
			my $tree = $pt.build-tree( $p );
			ok $pt.validate( $p ), Q{valid};
			is $pt.format( $tree ), $source, Q{formatted};
)
		}, Q{no ws};

		subtest {
			plan 0;

#`(
			my $source = Q:to[_END_];
enum Foo     (   )
_END_
			my $p = $pt.parse-source( $source );
			my $tree = $pt.build-tree( $p );
			ok $pt.validate( $p ), Q{valid};
			is $pt.format( $tree ), $source, Q{formatted};
)
		}, Q{leading ws};

		subtest {
			plan 0;

#`(
			my $source = Q{enum Foo(   )  };
			my $p = $pt.parse-source( $source );
			my $tree = $pt.build-tree( $p );
			ok $pt.validate( $p ), Q{valid};
			is $pt.format( $tree ), $source, Q{formatted};
)
		}, Q{trailing ws};

		subtest {
			plan 0;

#`(
			my $source = Q{enum Foo     (   )  };
			my $p = $pt.parse-source( $source );
			my $tree = $pt.build-tree( $p );
			ok $pt.validate( $p ), Q{valid};
			is $pt.format( $tree ), $source, Q{formatted};
)
		}, Q{leading, trailing ws};
	}, Q{intrabrace spacing};
}, Q{enum};

subtest {
	plan 2;

	subtest {
		plan 2;

		subtest {
			plan 2;

			my $source = Q:to[_END_];
subset Foo of Int
_END_
			my $p = $pt.parse-source( $source );
			my $tree = $pt.build-tree( $p );
			ok $pt.validate( $p ), Q{valid};
			is $pt.format( $tree ), $source, Q{formatted};
		}, Q{no ws};

		subtest {
			plan 2;

			my $source = Q{subset Foo of Int  };
			my $p = $pt.parse-source( $source );
			my $tree = $pt.build-tree( $p );
			ok $pt.validate( $p ), Q{valid};
			is $pt.format( $tree ), $source, Q{formatted};
		}, Q{trailing ws};
	}, Q{Normal version};

	subtest {
		plan 2;

		my $source = Q:to[_END_];
unit subset Foo;
_END_
		my $p = $pt.parse-source( $source );
		my $tree = $pt.build-tree( $p );
		ok $pt.validate( $p ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{unit form};
}, Q{subset};

subtest {
	plan 5;

	subtest {
		plan 2;

		my $source = Q:to[_END_];
constant Foo=1
_END_
		my $p = $pt.parse-source( $source );
		my $tree = $pt.build-tree( $p );
		ok $pt.validate( $p ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{no ws};

	subtest {
		plan 2;

		my $source = Q:to[_END_];
constant Foo     =1
_END_
		my $p = $pt.parse-source( $source );
		my $tree = $pt.build-tree( $p );
		ok $pt.validate( $p ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{leading ws};

	subtest {
		plan 2;

		my $source = Q:to[_END_];
constant Foo=   1
_END_
		my $p = $pt.parse-source( $source );
		my $tree = $pt.build-tree( $p );
		ok $pt.validate( $p ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{intermediate ws};

	subtest {
		plan 2;

		my $source = Q:to[_END_];
constant Foo     =   1
_END_
		my $p = $pt.parse-source( $source );
		my $tree = $pt.build-tree( $p );
		ok $pt.validate( $p ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{intermediate ws};

	subtest {
		plan 2;

		my $source = Q{constant Foo=1     };
		my $p = $pt.parse-source( $source );
		my $tree = $pt.build-tree( $p );
		ok $pt.validate( $p ), Q{valid};
		is $pt.format( $tree ), $source, Q{formatted};
	}, Q{trailing ws};
}, Q{constant};

# vim: ft=perl6
