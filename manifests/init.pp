# == Class
#
# pwd_mgmt
#
# == Synopsis
#
# This is the main ntp class for managing Linux system's time across a domain 
# with Puppet.
#
# == Author
#
# John McCarthy <midactsmystery@gmail.com>
#
# - http://www.midactstech.blogspot.com -
# - https://www.github.com/Midacts -
#
# == Date
#
# 7th of March, 2014
#
# -- Version 1.0 --
#
class ntp {

  case $::operatingsystem {
    redhat, centos: {
      $service	= 'ntpd'
    }
    debian, ubuntu: {
      $service	= 'ntpd'
    }
  }

  package { 'ntp':
    ensure	=> latest,
  }

  file { '/etc/ntp.conf/:
    ensure	=> present,
    content	=> template('ntp/ntp.conf.erb'),
    owner	=> root,
    group	=> root,
    require	=> Package['ntp'],
  }

  service { $service:
    enable	=> true,
    ensure	=> true,
  }

}
