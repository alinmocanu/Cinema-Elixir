defmodule Client do
    def client(nume, bani, bilet) do
        pid = spawn_link(Client,:init,[nume, bani, bilet])
        Process.register(pid, :client)
    end

    def init(nume, bani, bilet) do 
        IO.puts("Clientul solicita film")
        if bani > 15 do
            film = MovieDatabase.get |> Enum.random()
            bilet = MovieDatabase.update_seats_number(film)
            bani = bani - 15

        end

        send(pid_controlor, bilet);
    end

    def start_program(nr_spectatori, validare) do

    end

end