defmodule CinemaElixir.Tweet do
    def send(str) do
        ExTwitter.configure(:process,
            consumer_key: System.get_env("CINEMA_ELIXIR_CONSUMER_KEY"),
            consumer_secret: System.get_env("CINEMA_ELIXIR_CONSUMER_SECRET"),
            access_token: System.get_env("CINEMA_ELIXIR_ACCESS_TOKEN"),
            access_token_secret: System.get_env("CINEMA_ELIXIR_ACCESS_SECRET")
          )
          ExTwitter.update("update sample")
         # ExTwitter.user_timeline
        end
end