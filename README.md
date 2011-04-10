The rfc2047 ruby gem decodes email header fields that have been encoded according the the rules layed forth by [RFC 2047][1].

    Rfc2047.decode("=?ISO-8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=?= =?ISO-8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg==?=")
    # => "If you can read this yo u understand the example."

It is released under the same [terms][2] as Ruby itself.

It was originally written by Sam Roberts in 2003, and the current version was taken from the [Joyent Connector][3], who cite the original [mailing list post][4] as the source. It was packaged as a gem in 2011, and now resides on [Rubygems][5], with the source at [GitHub][6].

[1]: http://www.ietf.org/rfc/rfc2047.txt
[2]: http://www.ruby-lang.org/en/LICENSE.txt
[3]: http://dev.joyent.com/projects/connector/browse/trunk/vendor/rfc2047.rb
[4]: http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/69323
[5]: https://rubygems.org/gems/rfc2047
[6]: https://www.github.com/ConradIrwin/rfc2047-ruby
