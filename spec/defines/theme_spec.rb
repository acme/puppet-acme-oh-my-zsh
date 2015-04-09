require 'spec_helper'

testcases = {
  'user1' => {
    params: { },
    expect: { home: '/home/user1', theme:'clean' }
  },
  'user2' => {
    params: { theme: 'afowler' },
    expect: { home: '/home/user2', theme: 'afowler' }
  },
  'root' => {
    params: { theme: 'robbyrussell' },
    expect: { home: '/root', theme: 'robbyrussell' }
  },
}

describe 'ohmyzsh::theme' do
  testcases.each do |user, values|
    context "using case #{user}" do
      let(:title) { user }
      let(:params) { values[:params] }
      it do
        should contain_file_line("#{user}-#{values[:expect][:theme]}-install")
          .with_path("#{values[:expect][:home]}/.zshrc")
          .with_line(%Q(ZSH_THEME="#{values[:expect][:theme]}"))
      end
    end
  end
  context 'using bad data' do
    let(:title) { 'user' }
    context 'using array' do
      let(:params) { { theme: ['this','is an array'] } }
      it { expect { should compile }.to raise_error }
    end
    context 'using hash' do
      let(:params) { { theme: { 'this' => 'is a hash' } } }
      it { expect { should compile }.to raise_error }
    end
    context 'using integer' do
      let(:params) { { plugins: 1 } }
      it { expect { should compile }.to raise_error }
    end
  end
end
