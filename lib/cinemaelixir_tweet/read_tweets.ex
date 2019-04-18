defmodule CinemaElixir.ReadTweets do
    def get_tweets(hashtag) do
        ExTwitter.search(hashtag, [count: 100]) 
        |>Enum.map(fn(tweet) -> tweet.text end)
        |>Enum.filter(&String.length(&1)<=140)
        |>Enum.random()
    end
end