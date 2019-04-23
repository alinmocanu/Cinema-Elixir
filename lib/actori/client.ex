defmodule Client do
    def client(nume, prenume, bani, varsta) do
        pid = spawn_link(Client,:init,[nume, prenume, bani, varsta])
        age_string = Integer.to_string(varsta)
        pid_name = nume<>prenume<>age_string
        Process.register(pid, String.to_atom(pid_name))
    end

    def init(nume, prenume, bani, varsta) do 
        IO.puts("Clientul solicita film")
        if bani > 15 do
            film = MovieDatabase.get |> Enum.random()
            bilet = MovieDatabase.update_seats_number(film)
            if(bilet != -1) do
                accesGuard = Process.whereis(:acces_guard)
                send(accesGuard, {nume, prenume, bilet, varsta})
            else
                IO.puts "Nu mai sunt bilete"
            end
        else 
            IO.puts "#{nume} #{prenume} ai fonduri insuficiente"
        end
   
        receive do 
            {bilet} -> exit(:frauda) 
        end

    end


end