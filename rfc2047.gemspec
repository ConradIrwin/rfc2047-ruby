Gem::Specification.new do |s|
  s.name = "rfc2047"
  s.version = "0.2"
  s.platform = Gem::Platform::RUBY
  s.authors = ["Sam Roberts", "Conrad Irwin"]
  s.email = "conrad.irwin@gmail.com"
  s.homepage = "http://github.com/ConradIrwin/rfc2047-ruby/"
  s.summary = "Decodes email headers according to RFC2047"
  s.description = "Provides a method Rfc2047.decode that can decode individual headers encoded with this format."
  s.license = "Ruby"
  s.files = ["lib/rfc2047.rb", "README.md"]
  s.require_path = "lib"

  s.add_development_dependency "rake"
end
