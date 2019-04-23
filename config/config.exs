# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :extwitter, :oauth, [
  consumer_key: "GbvLKjl0NFgzlr1wJj7tRTSh5",
  consumer_secret: "YGZKwPdD15eiZJJIgb4Gt8WKyye8jBOHlcJcxWdF4Y08jIW2FQ",
  access_token: "1118479713373171712-qaqBSjYEja0bnKq32rTlsCLMqW5l1X",
  access_token_secret: "z8IR0La06dPJhZmpwTySwRf5P8GdtI3fd3oPINKHTPcBr"
]

config :cinema_elixir, CinemaElixir.Scheduler,
  jobs: [
    # Every minute
    {"* * * * *",      {CinemaElixir.Scheduler, :schedule_file, []}},
  ]
 # jobs: [
    # Every minute
 #   {"* * * * *",      {CinemaElixir.Scheduler, :schedule_file, []}},
  #  {{:cron, "* * * * *"},     {CinemaElixir.Scheduler, :schedule_file, []}},
  #]

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# third-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :cinema_elixir, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:cinema_elixir, :key)
#
# You can also configure a third-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"
