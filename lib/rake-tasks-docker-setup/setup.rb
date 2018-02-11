require 'deep_merge'
require 'yaml'

module RakeTasksDockerSetup
  module Setup
    extend self

    def overridesExist?
      File.exist?('docker-compose.override.yml')
    end

    def createOverrides
      overrides = merged_overrides
      message = "# This file has been generated by rake-tasks-docker-setup\n"
      File.write('docker-compose.override.yml', message + overrides.to_yaml) unless overrides.empty?
    end

    private

    def merged_overrides
      merged_hash = {}
      docker_compose_overrides.each do |overrides|
        merged_hash.deep_merge!(overrides)
      end
      merged_hash
    end

    def docker_compose_overrides
      docker_compose_files = %w[docker-compose.override.yml.dist]
      docker_compose_files << "docker-compose-dev-#{RUBY_PLATFORM.sub('darwin', 'macos').match(/(macos|linux)/)[1]}.yml"
      if RUBY_PLATFORM =~ /darwin/
        docker_compose_files << 'docker-compose-dev-macos-sync.yml' if %w[true yes y].include? ENV['RAKE_USE_DOCKER_SYNC']
        docker_compose_files << 'docker-compose-dev-macos-delegated.yml' unless %w[true yes y].include? ENV['RAKE_USE_DOCKER_SYNC']
      end
      docker_compose_files.select { |file| File.exist? file }.map { |file| YAML.load_file(file) }
    end
  end
end
