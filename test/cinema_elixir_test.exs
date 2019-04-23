defmodule CinemaElixirTest do
  use ExUnit.Case

  test "Passing a file should return a string" do
    CinemaElixir.FileReader.start("lib/cinemaelixir_tweet/movie_quotes.txt")
    str = CinemaElixir.FileReader.get_hashtag
    assert str != nil
  end

  test "Will not return a tweet longer than 140" do
    str = CinemaElixir.ReadTweets.get_tweets("#got")
    assert String.length(str) <= 140
  end

  test "Passing a hashtag sould return a string" do
    str = CinemaElixir.ReadTweets.get_tweets("#got")
    assert String.length(str) != nil
  end

  test "Database is not empty" do
    list = Database.read
    assert list != nil
  end
end
