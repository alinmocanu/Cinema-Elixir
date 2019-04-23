defmodule CinemaElixir.Meniu do
    def start do 
        IO.puts "--------------------Cinema  Elixir------------------\n"
        IO.puts "Available options \n"
        IO.puts "1. Display cinema program"
        IO.puts "2. Insert movie"
        IO.puts "3. Simulate actors"
        option = IO.gets(" Option: ")|>String.split("\n") 
                                     
        opt_int = String.to_integer(hd(option))
        
        case opt_int do 
            1 -> CinemaElixir.Meniu.display_program
            2 -> CinemaElixir.Meniu.insert_movie
            3 -> CinemaElixir.Meniu.simulate_actors
            _ -> CinemaElixir.Meniu.invalid_option
        end

        CinemaElixir.Meniu.start
    end

    def invalid_option do
        IO.puts "Invalid option"
        CinemaElixir.Meniu.start
    end

    def diplay_program do
        
    end

    def insert_movie do
        CinemaElixir.Supervisor.start_link
    end

    def simulate_actors do
        AccesGuard.create("Mihai")
        Client.client("Mocanu", "Alin", 20, 24)
        Client.client("Mocanu", "Sorin", 14, 20)
        Client.client("Alexandru", "Cosmin", 25, 10)
        CinemaElixir.Meniu.start
    end

end