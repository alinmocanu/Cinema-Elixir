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
                 CinemaElixir.Meniu.start
            2 -> CinemaElixir.Meniu.insert_movie
                CinemaElixir.Meniu.start
            3 -> CinemaElixir.Meniu.simulate_actors
                CinemaElixir.Meniu.start
            4 -> CinemaElixir.Meniu.statistics
                CinemaElixir.Meniu.start
            5 -> CinemaElixir.Meniu.sali
                CinemaElixir.Meniu.start            
            6 -> IO.puts("get out")
            _ -> CinemaElixir.Meniu.invalid_option
                CinemaElixir.Meniu.start
        end

        #CinemaElixir.Meniu.start
    end

    def invalid_option do
        IO.puts "Invalid option"
        CinemaElixir.Meniu.start
    end

    def display_program do
        Program.do_stuff
    end

    def statistics do
        Database.do_stuff
    end

    def sali do
        data = IO.gets(" Data: ")|>String.split("\n") 
        ora = IO.gets(" Ora: ")|>String.split("\n") 
        Sali.do_stuff(hd(data),hd(ora)) #"02.02.2019","21:00"
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