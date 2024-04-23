# frozen_string_literal: true

require_relative "lib/time_receive/version"

Gem::Specification.new do |spec|
  spec.name = "time_receive"
  spec.version = TimeReceive::VERSION
  spec.authors = ["MatveySviadysh"]
  spec.email = ["mkomp06@gmail.com"]

  spec.summary = "working with time display"
  spec.description = "The time_receive gem provides a way to ... (brief explanation of what the gem does).
                      It includes features such as ... (list some key features).
                      This gem is useful for ... (describe who would benefit from using the gem and why)."
  spec.homepage = "https://github.com/bodrovis/lokalise_rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
