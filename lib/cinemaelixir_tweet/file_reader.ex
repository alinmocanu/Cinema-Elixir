defmodule CinemaElixir.FileReader do
    use Agent 

    def start(path) do
        Agent.start_link(fn->%{} end, name: __MODULE__)
        CinemaElixir.FileReader.update(path)
        CinemaElixir.FileReader.value
    end


    def value do
        Agent.get(__MODULE__,& &1)
    end

    def update(path) do
        data = CinemaElixir.FileReader.get_hashtag(path)
        Agent.update(__MODULE__, &(&1=data))
    end



    def get_hashtag(path) do
        File.read!(path)
        |>String.split("\n") #facem split pe baza delimitatorului de linie
        |>Enum.map(&String.trim/1) #eliminamm spațiile albe
        |>Enum.random()

    end
end