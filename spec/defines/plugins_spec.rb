require 'spec_helper'

testcases = {
  'user1' => {
    params: { },
    expect: { home: '/home/user1', plugins:'git' }
  },
  'user2' => {
    params: { plugins: 'tmux' },
    expect: { home: '/home/user2', plugins: 'tmux' }
  },
  'root' => {
    params: { plugins: ['git', 'tmux'] },
    expect: { home: '/root', plugins: 'git tmux' }
  },
}

describe 'ohmyzsh::plugins' do
  testcases.each do |user, values|
    context "using case #{user}" do
      let(:title) { user }
      let(:params) { values[:params] }
      it do
        should contain_file_line("#{user}-#{values[:expect][:plugins]}-install")
          .with_path("#{values[:expect][:home]}/.zshrc")
          .with_line("plugins=(#{values[:expect][:plugins]})")
      end
    end
  end
  context 'using bad data' do
    let(:title) { 'user' }
    context 'using hash as plugins' do
      let(:params) { { plugins: { 'this' => 'is a hash' } } }
      it { expect { should compile }.to raise_error }
    end
    context 'using integer as plugins' do
      let(:params) { { plugins: 1 } }
      it { expect { should compile }.to raise_error }
    end
  end
end
