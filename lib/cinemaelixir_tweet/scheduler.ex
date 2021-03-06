defmodule CinemaElixir.Scheduler do
    use Quantum.Scheduler,
     otp_app: :cinema_elixir
    def schedule_file() do
      hashtag = CinemaElixir.FileReader.get_hashtag
        CinemaElixir.ReadTweets.get_tweets(hashtag)
        |> CinemaElixir.TweetServer.tweet
    end
end