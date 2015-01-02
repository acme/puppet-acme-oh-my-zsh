directories %w{manifests spec}

`rake spec_prep`

#guard 'rspec', cmd: 'rspec --color --format doc' do
guard 'rake', task: 'spec' do
  # Classes
  watch(%r{^manifests/(.+)\.pp$}) do |m|
    "spec/classes/#{m[1]}_spec.rb"
  end
  watch(%r{^spec/classes/(.+)_spec\.rb$}) do |m|
    "spec/classes/#{m[1]}.rb"
  end
end
