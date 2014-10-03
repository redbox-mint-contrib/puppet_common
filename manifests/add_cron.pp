define puppet_common::add_cron ($crontab = $title, $cron_path = undef,) {
  if ($cron_path) {
    create_resources(cron, $crontab, {
      environment => "PATH=${cron_path}:$PATH",
    }
    )
  } else {
    create_resources(cron, $crontab)
  }

}
