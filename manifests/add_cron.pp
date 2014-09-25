define puppet_common::add_cron ($crontab = $title,) {
  $cron_hash.each |$key, $value| {
    cron { $key:
      command => $value[command],
      user    => $value[user],
      hour    => $value[hour],
      minute  => $value[minute],
    }
  }
}