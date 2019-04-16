defmodule Database do


    def read do
        {:ok,contents} = File.read("lib/Program.txt")
        contents = contents |> String.split("\r\n", trim: true) #sparge fiecare linie citita separata
        #each Movie has name, date, time
        auxcontent = contents

        maplist = get_map(auxcontent)

    end

    def get_map(maplist,[]) do
        maplist
    end

    def get_map(maplist,list) do
        newmap = %{:titlu => elem(List.pop_at(list,0),0), :data => elem(List.pop_at(list,1),0), :ora => elem(List.pop_at(list,2),0), :sala => elem(List.pop_at(list,3),0)}
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        IO.puts list
        maplist = [maplist] ++ [newmap] #= map ++ newmap
        
        get_map(maplist,list)
    end
    def get_map (list) do
        newmap = %{:titlu => elem(List.pop_at(list,0),0), :data => elem(List.pop_at(list,1),0), :ora => elem(List.pop_at(list,2),0), :sala => elem(List.pop_at(list,3),0)}
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        IO.puts list
        maplist = newmap

        get_map(maplist,list)
    end

end