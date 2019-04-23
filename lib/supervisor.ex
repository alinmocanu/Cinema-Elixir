defmodule CinemaElixir.Supervisor do
    use Supervisor
  
    def start_link do
      Supervisor.start_link(__MODULE__, [])
    end
  
    def init([]) do
  
      children = [
        worker(AdaugFilme, [AdaugFilme], restart: :permanent),
       
      ]
      supervise(children, [strategy: :one_for_one, max_restarts: 5, max_seconds: 1000])
    end
  end