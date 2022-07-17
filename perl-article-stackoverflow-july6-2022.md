# Why Perl is still relevant in 2022

While Perl might seem like an outdated scripting language, it still has plenty
of relevant uses today.

If you love Unix/Linux/BSD like me, then you have definitely learnt Perl
and programmed in it. I am pretty certain you have also used Perl more
than once, perhaps several times. The language was created in 1987 as a
general purpose Unix scripting language, but has undergone many changes
since then (even spawning another programming language, 
[Raku](https://raku.org)). 

You may have used it for occasional sys admin tasks, in your tool chain,
or to enhance some shell scripts that needed more gas. But Perl is more
than just scripting. 

From the amount of talk about Perl on Reddit or Stack Overflow, you
might think it’s dead. It’s far from dead, and is still very relevant to
software engineering today. 

## What makes it special?

Perl is a high-level, interpreted language. It is open source and free to
contribute to.

Perl’s primary strength was in text processing. Be it a regex-based
approach or otherwise, Perl is excellent for logfile analysis, text
manipulation, in-place editing of files, and scouring structured text
files for specific field values.

Perl is very Unix-friendly. It can serve as a wrapper around Unix tools and is
fully integrated into OS semantics. As a result, it excels at pipes, file
slurping, inter-process communication and other geeky tasks. It can create Unix
daemons or server processes that run in the background. We can easily invoke a
Perl daemon to avoid spending hours working on C and reduce [security
flaws](https://portswigger.net/daily-swig/c-is-least-secure-programming-language-study-claims#:~:text=The%20top%20vulnerabilities%20found%20in,programming%20language%20in%20the%20list.).

Like [npm](https://www.npmjs.com/) for Node.js, Perl has a vibrant development
community in [CPAN](https://metacpan.org/), with a vast archive of Perl modules.
You can find a module to do anything you want. Most modules are written in
pure Perl, though some performance intensive modules have an XS component that
uses C for performance.

Through CPAN, you can wrap many databases—SQLite, MySQL, Postgres, and
more—in Perl code using database driver (DBD) modules. These export the
DB operations using Perl’s own semantics into unified portable Perl code
that hides the complexities of the database. 

Perl supports arrays, hashes, and references using which you can code in
very powerful ways without thinking deeply about data structures or
algorithms. Most CPAN modules give you both a procedural style as well
as the object oriented one. By giving you that choice, you can pretty
much do your task your own way.

## What sort of problems make Perl a natural?

As stated above, Perl does very well with text processing. It can scour CSV
files for data fields based on complex regex statements. It is a tool of choice
for parsing log files. It can quickly edit settings files. Perl is also a natural
for various format conversions, generating PDFs, HTML, or XML.

Since the early days of the internet, Perl served as the foundation of a lot of
basic networking tasks: common gateway interface (CGI), MIME decoding in emails,
or managing websockets between a client and server. It has evolved a lot since
the early times, becoming a source of inspiration for other ecosystems and
getting it's inspiration again from other languages to evolve.

For power Unix users, Perl allow to automate nearly any action that you
like. You can create daemons—small, constantly running programs—that
will automatically take actions when their conditions are met. 

Testing is at the core of Perl culture. Excellent [test toolkits and
infrastructures](http://www.modernperlbooks.com/mt/2009/04/a-test-infected-culture.html)
lay at the foundation of the community favorites methodologies.. Any module
uploaded to the CPAN will pass automatically through the *[CPAN Testers
Reports](http://www.cpantesters.org/page/about.html), a multi-platorm testing
ground that operate since 1998. Standard Perl tests can also be run in common
[build
pipelines](https://stackoverflow.com/questions/533553/perl-build-unit-testing-code-coverage-a-complete-working-example)
and CI.

## A flexible and fun way to code

In today’s event-loop-centric asynchronous world of JavaScript, Node.js, and
TypeScript, Perl developed ways to face the challenges of non blocking
programming.

Despite asynchronicity is not a fundamental of Perl's core, it is as always 
possible to extend the language through CPAN modules. An robust example is 
[`Future::AsyncAwait`](https://metacpan.org/pod/Future::AsyncAwait)) that
*provides syntax for deferring and resuming subroutines* with the `async` and
`await keywords`. An alternative can be
[`Mojo::Promise`](https://metacpan.org/pod/Mojo::Promise), a _Perl-ish
implementation of [Promises/A+](https://promisesaplus.com/) and a superset
of [ES6 Promises](https://duckduckgo.com/?q=\mdn%20Promise)_.

Perl includes a number of specialized operators that process data in
unique ways. You can use the diamond `<>` operator to eat up any stream,
file, socket, pipe, named pipe, whatever.

The regex operator `=~` opens the door to the rich world of Perl regular
expressions, that can reduce many lines of complex code to a couple of *match*
and *replace* operations.

Perl emphasizes the *get what you want the way you want* philosophy, 
also known as [TMTOWTDI](https://en.wikipedia.org/wiki/There%27s_more_than_one_way_to_do_it).

Perl is multi-paradigm. In addition to procedural or object-oriented, it allows
functional programming. Depending of the situation, it allows to choose the most
accurate programming paradigm. Providing a low level object-oriented system,
robust object toolkits like [Moose](https://metacpan.org/pod/Moose) can be used
for production code (from CPAN, not a core module). Such toolkits simplify
greatly the object oriented paradigm for Perl.

## Looking at some code

Let us examine some code samples to get some perspective by creating a sha256 digest of a string.

This is how you do in Node.js:

```javascript
const {
  createHash
} = require('node:crypto');

const hash = createHash('sha256');
data = 'Stack Overflow is cool';
hash.update(data);
console.log(hash.copy().digest('hex'));
```

In Perl let's examine two ways (*more ways* could be possible). One is the procedural
approach:

```perl
use Digest::SHA qw(sha256_hex);

my $data = 'Stack Overflow is cool';
my $hexdigest = sha256_hex($data);
print("Procedural interface :: " . $hexdigest . "\n");
```

Another is the object-oriented approach:

```perl
use Digest::SHA

my $sha = Digest::SHA->new('sha256');
$sha->add($data);               # feed data into stream
my $hexdigest = $sha->hexdigest;
print("OO interface ::" . $hexdigest);
```

Here’s how you do it in Python:

```python
import hashlib
m = hashlib.sha256()
m.update(b"Stack Overflow is cool")
print(m.hexdigest())
```

## Debugging

Perl has a `-c` switch to just compile the code to check for basic
syntax errors.

You can always use the `die()` diagnostic tool, the core `Data::Dumper` to 
dump your data structures, or [`Data::Printer`](https://metacpan.org/pod/Data::Printer)
to inspect complex objects.

All those allow to figure out causes in case something does not go as 
planned. Perl can also be run in debug mode with the `-d` switch.

## Comparing to other languages

### Python

Python has a built-in interactive shell where you can easily develop code and
learn. It is amazing and can helps newcomers to got to the point directly
without having to configure an entire environment. It can also help to evaluate
quick statements and prototypes, or just verify some syntax in everyday's life.

In Perl world, interactive shells exists from CPAN. Such examples are
[Reply](https://metacpan.org/release/Reply) or
[Devel::REPL](https://metacpan.org/pod/Devel::REPL) an effort to build a modern
repl.

A similar thing to mention from Perl world, that might be similar to REPL
environments, and a part of it's *folklore*, are the [Perl one
liners](https://catonmat.net/ftp/perl1line.txt), very short programs that
operate on lists, whole file lines, can generate, replace or encode at the
price of a very little effort, usually at the price of very little typing.

A good reason why Python serves as an excellent learner’s programming language
for that is Python isn't a TIMTOWTDI language at it's core. The fact that it
doesn't allow a wide variety of ways to implement something can make it more
straighforward and make it easier, for example, to apply code rules when joining
a team. It is also well known for it's *"batteries-included"* philosophy.

Python is an out and out object-oriented paradigm. Perl is a mix. Python
offers several functional programming concepts like lambda, map, and
friends, but it remains rooted in [OOP](https://stackoverflow.blog/2020/09/02/if-everyone-hates-it-why-is-oop-still-so-widely-spread/).

Perl is more invested in using traditional references and hash semantics
for subroutines and other advanced usage. Python tries to do it using
objects a little like how Node.js does it.

Python has Jupyter notebook that takes the power of Python to the
browser. Python scripts tend to be shorter than Perl in general. Python
has more economic syntax, excellent saving in lines of code by chaining
objects.

Sometimes it is not an apples to apples comparison as each programming
language has its own benefits and specific uses.

### Node.js

Node.js is object-oriented and asynchronous in it's core.

It's program flow require a good understanding of non-blocking programming. Even
experienced programmers struggle with code flow and figuring out when a function
returns. It can lead to callback hell, though promises and async/await make
things better—if they are used. But the event loop and single threaded Node.js
flow makes it harder to use for one off tasks.

If you wish to use a third-party library to solve a particular problem, you can
either do it using Node.js or Perl. The open source modules for plugging into
most third-party libraries exist for both languages. Most of the time, Node.js
relies on package.json and local installations of modules and Node.js. Despite
Perl wide availability on most systems, this is something that Perl community
tends to encourage with tools like [`perlbrew`](https://perlbrew.pl/), that
allows the admin-free installation of Perl and separation of the system `perl`
(allowing to have many versions installed). `perlbrew` is very similar to nvm
(the Node Version Manager). Another interesting tool is Carton, a modules
dependency manager, inspired by Ruby's [Bundler](https://bundler.io/) and
similar to Node.js `npm`, allowing to track, install, deploy or bundle your
applications dependencies.

### ksh or Bash

Well, this is a funny thing to write. Perl could be a contender for
shell-scripting jobs as it is a scripting language, correct? But Perl
installation is a factor to consider whether to use it or some shell in
a resource-constrained environment like Raspberry Pi or something.

A common opinion about shell scripts is that after more than a couple of lines,
you should consider rewritting them in Perl, Python, Go, Ruby, any high-level
language you like that allows the use of libraries that will help to handle
daily task easilier and avoid reinventing the wheel.

## The future of Perl

Because it continued to evolve by taking it's inspiration from other languages,
it can provide production ready implementations for event loops, promises,
object oriented programming. In the last few years, the
[Corinna](https://github.com/Ovid/Cor) specifications and
[Object::Pad](https://metacpan.org/pod/Object::Pad) implementation are preparing
the introduction of modern OOP in the Perl core.

It is continously improved by a large community and each release provide new
features that takes it to the next step. Notable examples being:

- v5.34 provides an experimental [`try / catch`
  syntax](https://perldoc.perl.org/5.34.0/perlsyn#Try-Catch-Exception-Handling)
  and the [`perlgov` documentation](https://perldoc.perl.org/5.34.0/perlgov),
  exposing goals, scope, system, and rules for Perl's new governance model,
- v5.36 provide non-experimental [subroutines
  signatures](https://perldoc.perl.org/5.36.0/perldelta#Core-Enhancements)

A couple of years ago, [Perl 7 was
announced](https://www.perl.com/article/announcing-perl-7/), what brings an end
to the Raku / Perl confusion and propose to bring the best of Modern Perl
practices to the front.

## Why it is still relevant in 2022

Perl is not going away even if it tends to be less trendy than other modern
languages.

It is used in production codebases of many
companies, for tasks as diverse as web development, databases access, log
analysis or web crawling. It is a core component of most unix-like systems.

Many legacy production systems rely on Perl and new Perl applications are
flourishing using the modern Perl toolkits available through CPAN. 

If CGI was an important historic part of the Perl culture until the mid 2000, it
was [removed from Perl core with 5.22 in
2014](http://www.modernperlbooks.com/mt/2013/05/ejecting-cgipm-from-the-perl-core.html).
Since a long time, CGI is not the recommended way to handle web development [in
favor of the alternatives](https://metacpan.org/pod/CGI::Alternatives) provided
by he community. Two notables web frameworks being [Dancer](https://dancer.pm)
and [Mojolicious](https://mojolicious.org).

In terms of bindings to other libraries and utilities, Perl is as good as other
choices. For instance, communication with
[libcurl](https://metacpan.org/pod/WWW::Curl) or
[libtls](https://github.com/rsimoes/Net-GnuTLS) or some third-party open-source
library or database, can be achieved with any language we like. Here, Perl
is supported out of the box and provide easy ways to get the job done.

Perl is perfectly capable of keeping up with modern trends. Code we write today
is not the same as that which we wrote 20 years ago. Other languages have
influenced the language as it became and we can expect that to continue and the
ecosystem to grow.

## Conclusion

Perl has always been very remarkable about its documentation and
tutorials — perhaps being too wordy at times — but clearly they are
developer-friendly.

Hopefully this article makes a case for Perl that is convincing and
reasonably objective based on current trends, usage statistics, and
developer base. A programmer is typically influenced by factors that
differ from that of a business need or a manager. In both cases, Perl
makes a case as it offers convenience, quick development times, and rich
community support and tooling.


