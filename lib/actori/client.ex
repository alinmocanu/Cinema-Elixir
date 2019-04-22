defmodule Client do
    def client(nume, prenume, bani, varsta) do
        pid = spawn_link(Client,:init,[nume, prenume, bani, varsta])
        pid_name = nume<>prenume<>Integer.to_string(varsta)
        Process.register(pid, String.to_atom(pid_name))
    end

    def init(nume, prenume, bani, varsta) do 
        IO.puts("Clientul solicita film")
        bilet = if bani > 15 do
            film = MovieDatabase.get |> Enum.random()
            bilet = MovieDatabase.update_seats_number(film)
            if(bilet != -1) do
                accesGuard = Process.whereis(:acces_guard)
                send(accesGuard, {nume, prenume, bilet, varsta})
            else
                IO.puts "Nu mai sunt bilete"
            end
        else 
            bilet = 0
        end
   
        receive do 
            {bilet} -> exit(:frauda) 
        end

    end


end