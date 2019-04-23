defmodule AdaugFilme do
  use GenServer

  def init(_) do
      {:ok, []}
  end

  def child_spec() do
      %{
        id: AdaugFilme,
        shutdown: 5_000,
        restart: :permanent,
        type: :worker,
        start: {__MODULE__, :start_link, []},
      }
    end
  
    def handle_call(:get_data, _, state) do
      {:reply, state, state}
    end
    def handle_cast(:increment, state) do
      {:noreply, state+1}
    end

    def start_link do
      GenServer.start_link(__MODULE__, [name: :add_movie])
      movieTitle = IO.gets(" Titlu: ")
      movieDate = IO.gets(" Data (02.02.2019): ")
      movieHour = IO.gets(" Ora (23:59): ")
      movieHall = IO.gets(" Sala: ")
      movieAgeLimit = IO.gets( " Limita varsta: ")
      movieHashtag = IO.gets(" Hashtag (#exemplu): ")

      File.write("lib/Program.txt", "\n\n" <> movieTitle, [:append]) |> IO.inspect
      File.write("lib/Program.txt", movieDate, [:append]) |> IO.inspect
      File.write("lib/Program.txt", movieHour, [:append]) |> IO.inspect
      File.write("lib/Program.txt", movieHall, [:append]) |> IO.inspect
      File.write("lib/Program.txt", movieAgeLimit, [:append]) |> IO.inspect
      File.write("lib/cinemaelixir_tweet/movie_quotes.txt", movieHashtag, [:append]) |> IO.inspect

      CinemaElixir.FileReader.update(movieHashtag)
      MovieDatabase.add_movie_to_database(movieTitle, movieHour, movieDate, movieHall, movieAgeLimit)

  
    end
end