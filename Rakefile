require 'fileutils'
require 'pathname'

files = Dir.glob('**/*.{vim,txt}').map {|f| Pathname(f) }
name = 'unite-colorscheme'

desc 'generate zip archive of the project, asking you the version'
task :zip do
  print "version: "
  version = STDIN.gets.chomp
  print "OK? "
  exit unless STDIN.gets.chomp == 'y'

  sh "mkdir -p #{name}-#{version}"
  files.each do |f|
    sh "mkdir -p #{name}-#{version}/#{f.dirname}"
    sh "cp #{f} #{name}-#{version}/#{f}"
  end
  sh "zip -r #{name}-#{version}.zip #{name}-#{version}"
  sh "rm -r #{name}-#{version}"
end
