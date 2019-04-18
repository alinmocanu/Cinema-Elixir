defmodule Database do
    use Agent

    def do_stuff do #Database.do_stuff - face statistica, numara fiecare film de cate ori ruleaza
        Database.start
        Database.update
        Database.value
    end

    def sali(data_film, ora_film) do #Database.sali("02.02.2019,"21:00") - toate filmele care ruleaza la data si ora aia
        Database.start
        Database.update_sali(data_film, ora_film)
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

    def update_sali(data_film, ora_film) do
        list = Database.read
        Enum.each list, fn(list) -> 
            if list.data == data_film and list.ora == ora_film do
                Database.update_agent_sali(list.sala, list.titlu) 
            else
            end
        end
    end
    
    def update_agent_sali(sala, titlu) do        
        Agent.update(__MODULE__,fn(state) ->             
                Map.put(state,sala,titlu)                                   
        end)
    end

    def value do
        Agent.get(__MODULE__,fn(state) -> state end)
    end

    #Functie vecheee, probabil nu mai e nevoie de ea
    # def get_movies(data_film, ora_film) do 
    #     list = Database.read
    #     map = %{}
    #     Enum.each list, fn(list) ->
    #         if list.data == data_film and list.ora == ora_film do
    #             IO.puts list.data
    #             IO.puts list.ora
    #             IO.puts list.sala
    #             IO.puts Map.get(list, :titlu)
    #             IO.puts Macro.to_string(quote do: unquote(list.titlu))
    #             map = Map.put(map, Map.get(list, :sala), Map.get(list, :titlu))
    #             map = Map.put(map, Macro.to_string(quote do: unquote(list.sala)), Macro.to_string(quote do: unquote(list.titlu)))
    #             map = Map.put(map, list.sala, list.titlu)
    #             IO.puts true                
    #         else
    #             IO.puts false
    #         end
    #     end
    #     map
    # end

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
        newmap = %{:titlu => elem(List.pop_at(list,0),0), :data => elem(List.pop_at(list,1),0), :ora => elem(List.pop_at(list,2),0), :sala => elem(List.pop_at(list,3),0)}
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        maplist = maplist ++ [newmap] 
        get_map(maplist,list)
    end
    def get_map (list) do
        newmap = %{:titlu => elem(List.pop_at(list,0),0), :data => elem(List.pop_at(list,1),0), :ora => elem(List.pop_at(list,2),0), :sala => elem(List.pop_at(list,3),0)}
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        list=List.delete_at(list,0)
        maplist = [newmap]
        get_map(maplist,list)
    end

end