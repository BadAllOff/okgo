scope groups: [:specs]

rspec_options = {
    cmd: "bundle exec rspec",
}

group 'specs' do
  guard :rspec, rspec_options do
    require "guard/rspec/dsl"
    dsl = Guard::RSpec::Dsl.new(self)

    # RSpec files
    rspec = dsl.rspec
    watch(rspec.spec_helper) { rspec.spec_dir }
    watch(rspec.spec_support) { rspec.spec_dir }
    watch(rspec.spec_files)

    # Ruby files
    ruby = dsl.ruby
    dsl.watch_spec_files_for(ruby.lib_files)

    # Rails files
    rails = dsl.rails(view_extensions: %w(erb haml slim))
    dsl.watch_spec_files_for(rails.app_files)
    dsl.watch_spec_files_for(rails.views)

    watch(rails.controllers) do |m|
      [
        rspec.spec.call("controllers/#{m[1]}_controller"),
        rspec.spec.call("models/#{m[1]}"),
        rspec.spec.call("factories/#{m[1]}")
      ]
    end

    # Rails config changes
    watch(rails.spec_helper)     { rspec.spec_dir }
    watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
    watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }
  end

  guard :bundler do
    require 'guard/bundler'
    require 'guard/bundler/verify'
    helper = Guard::Bundler::Verify.new

    files = ['Gemfile']
    files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

    # Assume files are symlinked from somewhere
    files.each { |file| watch(helper.real_path(file)) }
  end
end

group 'server' do
  guard 'rails' do
    watch('Gemfile.lock')
    watch(%r{^(config|lib)/.*})
  end
end
