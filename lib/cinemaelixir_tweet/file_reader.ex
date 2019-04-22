defmodule CinemaElixir.FileReader do
    use Agent 

    def start(path) do
        Agent.start_link(fn->CinemaElixir.FileReader.get_hashtags(path) end, name: :hashtags)
    end

    def get do
        Agent.get(:hashtags, fn(state) -> state end)
    end

    def get_hashtag do
        CinemaElixir.FileReader.get |> Enum.random()
    end

    def update(hashtag) do
        Agent.update(:hashtags, fn(state)-> state = [hashtag| state] end)
    end

    def get_hashtags(path) do
        File.read!(path)
        |>String.split("\n") 
        |>Enum.map(&String.trim/1) 
    end
end