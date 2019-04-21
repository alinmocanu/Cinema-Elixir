defmodule CinemaElixir.Scheduler do
    use Quantum.Scheduler,
     otp_app: :cinema_elixir
    def schedule_file() do

      hashtag = CinemaElixir.FileReader.start("C:\\Users\\Cosmin Alex\\Desktop\\Cinema-Elixir\\lib\\cinemaelixir_tweet\\movie_quotes.txt")
        CinemaElixir.ReadTweets.get_tweets(hashtag)
        |> CinemaElixir.TweetServer.tweet
    end
end