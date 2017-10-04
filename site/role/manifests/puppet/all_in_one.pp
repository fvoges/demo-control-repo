class role::puppet::all_in_one {

  include ::profile::base
  include ::profile::puppet::master
  include ::profile::puppet::backup
  #include ::pe_code_manager_webhook
  #include ::pe_metric_curl_cron_jobs

}