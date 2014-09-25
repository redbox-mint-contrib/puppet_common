define puppet_common::add_cron ($crontab = $title,) {
  create_resources(cron, $crontab)

}