defmodule Database do
    use Agent

    def do_stuff do #Database.do_stuff - face statistica, numara fiecare film de cate ori ruleaza
        Database.start
        Database.update
        Database.value
    end
    
    def start do
        Agent.start_link(fn -> %{} end, name: __MODULE__)
    end
    
    def update do
        data = Database.read
        Enum.each data, fn(data) -> Database.update_agent(data.titlu) end
    end
    
    def update_agent(movie) do        
        Agent.update(__MODULE__,fn(state) -> 
            if Map.get(state,movie) === nil do
                Map.put(state,movie,1) 
            else 
                count = Map.get(state,movie)
                Map.put(state,movie,count + 1)      
            end        
        end)
    end
    
    def value do
        Agent.get(__MODULE__,fn(state) -> state end)
    end

    def read do
        {:ok,contents} = File.read("lib/Program.txt")
        contents = contents |> String.split("\r\n", trim: true) #sparge fiecare linie citita separata
        #each Movie has name, date, time, room
        auxcontent = contents
        get_map(auxcontent)        
    end

    def get_map(maplist,[]) do
        maplist
    end

    def get_map(maplist,list) do
        newmap = %{:titlu => elem(List.pop_at(list,0),0),
                   :data => elem(List.pop_at(list,1),0),
                   :ora => elem(List.pop_at(list,2),0), 
                   :sala => elem(List.pop_at(list,3),0),
                   :varsta =>elem(List.pop_at(list,4),0),
                   :locuri => 5}
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        maplist = maplist ++ [newmap] 
        get_map(maplist,list)
    end
    def get_map (list) do
        newmap = %{:titlu => elem(List.pop_at(list,0),0),
                   :data => elem(List.pop_at(list,1),0), 
                   :ora => elem(List.pop_at(list,2),0), 
                   :sala => elem(List.pop_at(list,3),0), 
                   :varsta =>elem(List.pop_at(list,4),0),
                   :locuri => 5}
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        maplist = [newmap]
        get_map(maplist,list)
    end

end