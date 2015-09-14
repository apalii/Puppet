Берем любой конфиг (LocalSettings.php), копируем в папку темплейтов, переименовуем на erb и заменяем переменные.
Пример:

/etc/puppet/environments/production/modules/ourproject/templates/LocalSettings.erb
```php
$wgSitename = "<%= wikisitename %>";
$wgMetaNamespace = "<%= wikimetanamespace %>";
$wgServer = "<%= wikiserver %>";
...
```

Все переменные нужно указать в nodes.pp:
```puppet
node wiki {
  $wgSitename = 'wiki'
  $wgMetaNamespace = 'Wiki'
  $wgServer = "http://172.31.0.202"
  }
```

а в modules/mediawiki/manifests/init.pp пишем сделующее:
```puppet
file { 'LocalSettings.php':
  path    => '/var/www/html/LocalSettings.php',
  ensure  => 'file',
  content => template('mediawiki/LocalSettings.erb'),
}
```
