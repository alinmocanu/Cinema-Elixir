defmodule CinemaElixir.FileReader do
    def get_hashtag(path) do
        File.read!(path)
        |>String.split("\n") #facem split pe baza delimitatorului de linie
        |>Enum.map(&String.trim/1) #eliminamm spațiile albe
        |>Enum.random()

    end
end