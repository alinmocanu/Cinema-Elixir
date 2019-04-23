defmodule CinemaElixir do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    MovieDatabase.start
    CinemaElixir.FileReader.start("lib\\cinemaelixir_tweet\\movie_quotes.txt")
    CinemaElixir.Supervisor.start_link()

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: PluralsightTweet.Worker.start_link(arg1, arg2, arg3)
      worker(CinemaElixir.TweetServer, []),
      worker(CinemaElixir.Scheduler, []),
      worker(CinemaElixir.Supervisor, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one,
     name: CinemaElixir.Supervisor]
    process = Supervisor.start_link(children, opts)
    process
  end
end
