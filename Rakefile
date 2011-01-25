require 'bundler'
Bundler::GemHelper.install_tasks

task :default => :test

desc "unit tests"
task :test do
  exec 'bundle exec rspec test/**/*'
end

EXAMPLE_NAMES = Dir['examples/*.rb'].map{|n|n.gsub(/examples\/([a-z_]+)\.rb/,'\1')}

WIDTH = 800
HEIGHT = 600
QUALITY = 11

directory 'output'

EXAMPLE_NAMES.each do |name|
  task "output/#{name}.pov" => [ 'output', "examples/#{name}.rb" ] do
    sh "ruby examples/#{name}.rb > output/#{name}.pov"
  end
  task "output/#{name}.png" => "output/#{name}.pov"do
    sh "povray +Ooutput/#{name}.png +FP -D Antialias=1 Width=#{WIDTH} Height=#{HEIGHT} Quality=#{QUALITY} output/#{name}.pov"
  end
end

task :example_png_files => EXAMPLE_NAMES.map{|n|"output/#{n}.png"}

desc "Build all example scenes"
task :examples => :example_png_files
