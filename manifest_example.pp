class linux {
    
    $admintools = ['git', 'nano', 'screen']

    package { $admintools:
        ensure => 'installed ',
    }

    $ntpservice = $osfamily ? {
        'redhat' => 'ntpd',
        'debian' => 'ntp',
        default => 'ntp',
    }

    file { '/info.text':
        ensure  => 'present',
        content => inline_template("Created by me at <%= Time.now %>\n"),
    }

    package { 'ntp':
        ensure => 'installed',
    }
    
    package { 'vim':
        ensure => 'absent',
    }
    
    service { $ntpservice:
        ensure => 'installed',
        enabled => true,
    }
}


node 'somenode1' {

    class { 'linux': }

}

node 'somenode2' {

    class { 'linux': }

}
