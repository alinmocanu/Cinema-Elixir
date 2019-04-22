defmodule Client do
    def client(nume, bani, bilet, varsta) do
        pid = spawn_link(Client,:init,[nume, bani, bilet, varsta])
        Process.register(pid, String.to_atom(nume))
    end

    def init(nume, bani, bilet, varsta) do 
        IO.puts("Clientul solicita film")
        bilet = if bani > 15 do
            film = MovieDatabase.get |> Enum.random()
            bilet = MovieDatabase.update_seats_number(film)
            accesGuard = Process.whereis(:acces_guard)
            send(accesGuard, {bilet, nume, varsta})

        else 
            bilet = 0
        end
        IO.puts bilet
   
        receive do 
            {bilet} -> exit(:frauda) 
        end

    end


end