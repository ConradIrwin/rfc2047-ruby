
#!/usr/bin/ruby -w

require 'lib/rfc2047'
require 'test/unit'

=begin

From RFC 2047:

8. Examples

   The following are examples of message headers containing 'encoded-
   word's:

   =?US-ASCII?Q?Keith_Moore?= <moore / cs.utk.edu>

   =?ISO-8859-1?Q?Keld_J=F8rn_Simonsen?= <keld / dkuug.dk>

   =?ISO-8859-1?Q?Andr=E9?= Pirard <PIRARD / vm1.ulg.ac.be>

   =?ISO-8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=?= =?ISO-8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg==?=

   =?ISO-8859-1?Q?Olle_J=E4rnefors?= <ojarnef / admin.kth.se>

   =?ISO-8859-1?Q?Patrik_F=E4ltstr=F6m?= <paf / nada.kth.se>

   Nathaniel Borenstein <nsb / thumper.bellcore.com> (=?iso-8859-8?b?7eXs+SDv4SDp7Oj08A==?=)

=end

class TestVcard < Test::Unit::TestCase

  def test_cases

    # Test Cases:
    #
    # Hash {
    #   encoded-string =>
    #      Hash {
    #         conversion_to_do => result_string
    #      }
    # }
    cases = {
      '=?US-ASCII?Q?Keith_Moore?= <moore / cs.utk.edu>' => {
        'utf-8' => 'Keith Moore <moore / cs.utk.edu>',
        'ascii' => 'Keith Moore <moore / cs.utk.edu>',
        'us-ascii' => 'Keith Moore <moore / cs.utk.edu>',
        'ascii' => 'Keith Moore <moore / cs.utk.edu>',
      },

      '=?ISO-8859-1?Q?Keld_J=F8rn_Simonsen?= <keld / dkuug.dk>' => {
        'iso-8859-1' => "Keld J\xF8rn Simonsen <keld / dkuug.dk>",
        'utf-8' => "Keld J\303\270rn Simonsen <keld / dkuug.dk>"
      },

      '=?ISO-8859-1?Q?Andr=E9?= Pirard <PIRARD / vm1.ulg.ac.be>' => {
        'iso-8859-1' => "Andr\xe9 Pirard <PIRARD / vm1.ulg.ac.be>",
      },

      '=?ISO-8859-1?B?SWYgeW91IGNhbiByZWFkIHRoaXMgeW8=?= =?ISO-8859-2?B?dSB1bmRlcnN0YW5kIHRoZSBleGFtcGxlLg==?=' => {
        'iso-8859-1' => 'If you can read this yo u understand the example.',
      },

      '=?ISO-8859-1?Q?Olle_J=E4rnefors?= <ojarnef / admin.kth.se>' => {'iso-8859-1' => "Olle J\xE4rnefors <ojarnef / admin.kth.se>",
      },

      '=?ISO-8859-1?Q?Patrik_F=E4ltstr=F6m?= <paf / nada.kth.se>' => {
        'iso-8859-1' => "Patrik F\xE4ltstr\xF6m <paf / nada.kth.se>",
      },

      'Nathaniel Borenstein <nsb / thumper.bellcore.com> (=?iso-8859-8?b?7eXs+SDv4SDp7Oj08A==?=)' => {
        'iso-8859-8' => "Nathaniel Borenstein <nsb / thumper.bellcore.com> (\355\345\354\371 \357\341 \351\354\350\364\360)",
        'utf-8'      => "Nathaniel Borenstein <nsb / thumper.bellcore.com> (\327\235\327\225\327\234\327\251 \327\237\327\221 \327\231\327\234\327\230\327\244\327\240)",
      },

    }

    cases.each do
      |src, conversions|

      conversions.each do
        |toset, expected|

        dst = Rfc2047.decode(src, toset)

        puts "#{src} -- (#{toset}) --> #{dst.inspect}"

        assert_equal(expected, dst)
       end
    end
  end
end
