# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rake-tasks-docker-setup/version'

Gem::Specification.new do |spec|
  spec.name          = "rake-tasks-docker-setup"
  spec.version       = RakeTasksDockerSetup::VERSION
  spec.authors       = ["Andy Thompson", "Kieren Evans"]
  spec.email         = ["athompson@inviqa.com", "kevans+rake-tasks-docker@inviqa.com"]

  spec.summary       = %q{Docker setup tasks for Rake}
  spec.description   = %q{Docker setup tasks for Rake}
  spec.homepage      = ""
  spec.licenses = ["MIT"]

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rake", ">= 10.0", "<= 12"
  spec.add_dependency "deep_merge", "~> 1.0"

  spec.add_development_dependency "rspec", "~> 3.6"
end
