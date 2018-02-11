require_relative 'setup'

namespace :docker do
  task :up => 'docker:first_setup'

  task :setup do
    RakeTasksDockerSetup::Setup.createOverrides
  end

  task :first_setup do
    Rake::Task['docker:setup'].invoke unless RakeTasksDockerSetup::Setup.overridesExist?
  end
end
