defmodule CinemaElixir.Scheduler do
    use Quantum.Scheduler, otp_app: :cinema_elixir
    def schedule_file() do
        IO.puts CinemaElixir.FileReader.get_movie_quotes("C:\\Users\\Cosmin Alex\\Desktop\\Cinema-Elixir\\lib\\cinemaelixir_tweet\\movie_quotes.txt") 
    end
end