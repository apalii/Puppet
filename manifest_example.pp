class linux {

    $admintools = ['git', 'nano', 'screen']

    package {
        ensure => 'installed ',
    }

    $ntpservice = $osfamily ? {
        'redhat' => 'ntpd',
        'debian' => 'ntp',
        default => 'ntp',
    }

    file { '/info.text'
        ensure  => 'present',
        content => inline_template("Created by me at <%= Time.now %>\n")
    }

    package { 'ntp':
        ensure => 'installed',
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
