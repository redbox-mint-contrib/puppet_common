define puppet_common::add_cron ($crontab = $title, $cron_path = undef,) {
  create_resources(cron, $crontab, {
    environment => "PATH=${cron_path}:$PATH",
  }
  )

}