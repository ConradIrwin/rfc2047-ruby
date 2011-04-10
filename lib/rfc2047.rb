# from http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/69323
# via http://dev.joyent.com/projects/connector/browse/trunk/vendor/rfc2047.rb
#
# An implementation of RFC 2047 decoding.
#
# This module depends on the iconv library by Nobuyoshi Nakada, which I've 
# heard may be distributed as a standard part of Ruby 1.8.
#
# Copyright (c) Sam Roberts <sroberts / uniserve.com> 2003 (with modifications).
#
# This file is distributed under the same terms as Ruby.

require 'iconv'

module Rfc2047

  WORD = /=\?([!#$\%&'*+-\/0-9A-Z\\^\`a-z{|}~]+)\?([BbQq])\?([!->@-~]+)\?=/ # :nodoc:

  # Look for two adjacent words in the same encoding.
  ADJACENT_WORDS = /(#{WORD})[\s\r\n]+(?==\?(\2)\?([BbQq])\?)/

  # Decodes a string, +from+, containing RFC 2047 encoded words into a target
  # character set, +target+ defaulting to utf-8. See iconv_open(3) for information on the
  # supported target encodings. If one of the encoded words cannot be
  # converted to the target encoding, it is left in its encoded form.
  def self.decode(from, target='utf-8')
    from.gsub(ADJACENT_WORDS, "\\1").gsub(WORD) do |word|
      cs = $1
      encoding = $2
      text = $3
      # B64 or QP decode, as necessary:
      case encoding.downcase
      when 'b'
        text = text.unpack('m*')[0]
      when 'q'
        # RFC 2047 has a variant of quoted printable where a ' ' character
        # can be represented as an '_', rather than =32, so convert
        # any of these that we find before doing the QP decoding.
        text = text.tr("_", " ")
        text = text.unpack('M*')[0]
      else
        raise Unparseable, from
      end
      # Convert
      #
      # Remember: Iconv.open(to, from)
      begin
        text = Iconv.open(target, cs) {|i| i.iconv(text)}
      rescue 
        raise Unparseable, from
      end
    end
  end

  class Unparseable < RuntimeError; end
end

