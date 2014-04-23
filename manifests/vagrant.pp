class { 'ohmyzsh': }

# for a single user
ohmyzsh::install { 'vagrant': }->
ohmyzsh::upgrade { 'vagrant': }
