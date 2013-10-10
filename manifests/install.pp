define oh-my-zsh::install() {
  exec { 'oh-my-zsh::git clone':
    creates => "/home/$name/.oh-my-zsh",
    command => "/usr/bin/git clone git://github.com/robbyrussell/oh-my-zsh.git /home/$name/.oh-my-zsh",
    user    => $name,
    require => [Package['git'], Package['zsh']]
  }

  exec { 'oh-my-zsh::cp .zshrc':
    creates => "/home/$name/.zshrc",
    command => "/bin/cp /home/$name/.oh-my-zsh/templates/zshrc.zsh-template /home/$name/.zshrc",
    user    => $name,
    require => Exec['oh-my-zsh::git clone'],
  }

  user { "oh-my-zsh::user $name":
    name    => $name,
    ensure  => present,
    shell   => '/usr/bin/zsh',
    require => Package['zsh'], 
  }
}
