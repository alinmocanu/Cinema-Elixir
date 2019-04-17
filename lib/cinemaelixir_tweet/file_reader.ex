defmodule CinemaElixir.FileReader do
    def get_movie_quotes(path) do
        File.read!(path)
        |>String.split("\n") #facem split pe baza delimitatorului de linie
        |>Enum.map(&String.trim/1) #eliminamm spațiile albe
        |>Enum.filter(&String.length(&1)<=140) #luam in calcul doar pe cele de lungime buna

    end
end