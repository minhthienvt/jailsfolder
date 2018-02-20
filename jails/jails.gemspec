
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jails/version"

Gem::Specification.new do |spec|
  spec.name          = "jails"
  spec.version       = Jails::VERSION
  spec.authors       = ["Steve Carey"]
  spec.email         = ["steve981cr@gmail.com"]

  spec.summary       = %q{For-learning-purposes-only web application framework.}
  spec.description   = %q{Ruby in Jails is a cheap, primitive, amateur attempt at a Web MVC framework strictly for learning purposes.}
  spec.homepage      = "https://www.techandstartup.org/tutorials/build-your-own-rails"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir["LICENSE.txt","Rakefile","README.md","jails.gemspec","lib/**/*"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "rack", "~> 2.0"
end
