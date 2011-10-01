LogBuddy.init({
  :logger   => Logger,
  :disabled =>  (ENV['RAILS_ENV'] == "production"),
})
