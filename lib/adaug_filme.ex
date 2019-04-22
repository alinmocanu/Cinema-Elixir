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

      def is_date?(date) do
        case Date.from_iso8601(date) do
          {:ok, _} -> true
          _ -> false
        end
      end

      def start_link(name ) do

        movieTitle = IO.gets(" Titlu: ")
        movieDate = IO.gets(" Data (2015-01-23): ")
        movieHour = IO.gets(" Ora (23:59): ")
        movieHall = IO.gets(" Sala: ")
        movieAgeLimit = IO.gets( "Age limit: ")
        movieHashtag = IO.gets("Hashtag: ")

        File.write("lib/Program.txt", "\n" <> movieTitle, [:append]) |> IO.inspect
        File.write("lib/Program.txt", movieDate, [:append]) |> IO.inspect
        File.write("lib/Program.txt", movieHour, [:append]) |> IO.inspect
        File.write("lib/Program.txt", movieHall, [:append]) |> IO.inspect
        File.write("lib/Program.txt", movieAgeLimit, [:append]) |> IO.inspect
        File.write("lib/cinemaelixir_tweet/movie_quotes.txt", movieHashtag, [:append]) |> IO.inspect

        

        GenServer.start_link(__MODULE__, [name: name])
    
      end

      def functie() do
      end



end