defmodule CinemaElixirTest do
  use ExUnit.Case

  test "greets the world" do
    assert 1 + 1 == 2
  end

  test "Passing a file should return a string" do
    CinemaElixir.FileReader.start("lib/cinemaelixir_tweet/movie_quotes.txt")
    str = CinemaElixir.FileReader.get_hashtag
    assert str != nil
end

end
