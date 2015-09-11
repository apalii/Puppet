# Puppet
Puppet Examples

Run puppet agent once :  
$ sudo puppet agent --verbose --no-daemonize --onetime

## Creating modules
 
```bash
cd /etc/puppet/environments/production/modules
sudo puppet module generate mediawiki --environment production
--> enter version
--> licence (skip)
--> describe (install and configure mediaWIKI)
...
```
As a result 'init.pp' file will be created.

### Conditions : 

```puppet
$phpmyadmin = $osfamily ? {
    'redhat' => 'php-mysql',
    'debian' => 'php5-mysql',
    default => 'php-mysql',
}

package { 'ntp':
    ensure => 'present ',
}

if $osfamily == 'redhat' {
    package { 'php-xml':
        ensure => 'present'
        }
}
```

### Installing modules from forge.puppetlabs.com/modules
$ sudo puppet module install puppetlabs-apache --modulepath /etc/puppet/envs/production/modules

in init.pp :

```puppet
class { '::apache': 
  docroot    => '/var/www/html',
  mpm_module => 'prefork',
  subscribe  => Package[$phpmysql],
  }

class { '::apache::mod::php': }
```
### GIT 
Go to forge.puppetlabs.com/modules  and find "vcsrepo"
index.html file should be deleted, cuz GIT cant put files in not empty folder
We can fix it using ordering :
```File['/var/ww/html/index.html'] -> Vcsrepo['/var/www/html']```

```puppet
class { '::apache::mod::php':
vcsrepo { '/var/www/html':
  ensure   => 'present',
  provider => 'git',
  source   => 'https://github.com/wikimedia/mediawiki.git',
  revision => 'REL1_23',
  }
  file { '/var/www/html/index.html':
    ensure => 'absent',
  }
  
  File['/var/ww/html/index.html'] -> Vcsrepo['/var/www/html']
}
```

### MySQL module
Go to forge.puppetlabs.com/modules  and find "mysql"
https://forge.puppetlabs.com/puppetlabs/mysql
```puppet
class { '::mysql::server':
  root_password           => 'strongpassword',
  remove_default_accounts => true,
  override_options        => $override_options
}
```

### FIREWALL
Go to forge.puppetlabs.com/modules
https://forge.puppetlabs.com/puppetlabs/firewall
```puppet
class { '::firewall':
firewall { '000 allow http access':
  port => '80',
  proto => 'tcp',
  action => 'accept,
  }
}
```
