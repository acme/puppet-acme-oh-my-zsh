require 'spec_helper'

testcases = {
  'user1' => {
    params: { },
    expect: { home: '/home/user1', sh: false }
  },
  'user2' => {
    params: { set_sh: true },
    expect: { home: '/home/user2', sh: true }
  },
  'root' => {
    params: { },
    expect: { home: '/root', sh: false }
  },
}

describe 'ohmyzsh::install' do
  testcases.each do |user, values|
    context "testing #{user}" do
      let(:title) { user }
      let(:params) { values[:params] }
      it do
        should contain_exec("ohmyzsh::git clone #{user}")
          .with_creates("#{values[:expect][:home]}/.oh-my-zsh")
          .with_command("git clone https://github.com/robbyrussell/oh-my-zsh.git #{values[:expect][:home]}/.oh-my-zsh || rmdir ${home}/.oh-my-zsh && exit 1")
          .with_user(user)
      end
      it do
        should contain_exec("ohmyzsh::cp .zshrc #{user}")
          .with_creates("#{values[:expect][:home]}/.zshrc")
          .with_command("cp #{values[:expect][:home]}/.oh-my-zsh/templates/zshrc.zsh-template #{values[:expect][:home]}/.zshrc")
          .with_user(user)
      end
      if values[:expect][:sh]
        it do
          should contain_user("ohmyzsh::user #{user}")
            .with_name(user)
            .with_shell("/usr/bin/zsh")
        end
      end
    end
  end #testcases.each
end #describe
