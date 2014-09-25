define puppet_common::add_cron ($crontab = $title,) {
  $crontab.each |$key, $value| {
    cron { $key:
      command => $value[command],
      user    => $value[user],
      hour    => $value[hour],
      minute  => $value[minute],
    }
  }
}