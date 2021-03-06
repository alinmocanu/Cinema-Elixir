defmodule MovieDatabase do
use Agent
    def start do
        Agent.start_link(fn -> Database.read end, name: :database_structure )
    end
    
    def get do
        Agent.get(:database_structure, fn(state) -> state end)
    end
    
    def add_movie_to_database(nume_film, ora, data, sala, varsta) do
        film = %{:titlu => nume_film,
        :data => data, 
        :ora => ora, 
        :sala => sala, 
        :varsta => varsta,
        :locuri => 5}
        Agent.update(:database_structure, fn(state)-> state = [film| state] end)
    end

    def get_age_limit(movie) do
        index = Enum.find_index(MovieDatabase.get, fn x -> Map.equal?(x, movie) end )
        current_movie = Enum.at(MovieDatabase.get, index) 
        Map.get(current_movie, :varsta) 
    end

    def get_current_seats_number(movie) do
        index = Enum.find_index(MovieDatabase.get, fn x -> Map.equal?(x, movie) end )
        current_movie = Enum.at(MovieDatabase.get, index)
        Map.get(current_movie, :locuri)
    end

    def update_seats_number(movie) do
        valid = MovieDatabase.get_age_limit(movie)
        nr_locuri_actuale = MovieDatabase.get_current_seats_number(movie)
        valid = if nr_locuri_actuale > 0 do
            index = Enum.find_index(MovieDatabase.get, fn x -> Map.equal?(x, movie) end )
            current_movie = Enum.at(MovieDatabase.get, index)
            new_movie = Map.replace!(current_movie, :locuri,  nr_locuri_actuale-1)
            Agent.update(:database_structure, fn(state)-> List.update_at(state, index,&(&1 = new_movie)) end)
            valid
        else
            valid = -1
        end
        valid 
    end
end