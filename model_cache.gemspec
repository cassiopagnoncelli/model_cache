
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "model_cache/version"

Gem::Specification.new do |spec|
  spec.name          = "model_cache"
  spec.version       = ModelCache::VERSION
  spec.authors       = ["Cássio Jandir Pagnoncelli"]
  spec.email         = ["cassiopagnoncelli@gmail.com"]

  spec.summary       = %q{ActiveRecord cache}
  spec.description   = %q{Caches ActiveRecord objects to Redis using primary key}
  spec.homepage      = "https://bitbucket.org/plipag/model_cache"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://bitbucket.org/plipag/model_cache.git"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://bitbucket.org/plipag/model_cache"
    spec.metadata["changelog_uri"] = "https://bitbucket.org/plipag/model_cache/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "activesupport"
end
