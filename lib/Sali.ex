defmodule Sali do
    use GenServer    
    
    def do_stuff do
        {:ok,pid} = Sali.start
        Sali.add(pid,"02.02.2019","21:00")
        Sali.view(pid)
        #Process.alive?(pid)
    end
    #client
    def start do #runs in the caller context client
        GenServer.start_link(__MODULE__,%{})
    end
    
    def add(pid,date,time) do
        GenServer.cast(pid, {date,time})
    end

    def view(pid) do
        GenServer.call(pid, :view)
    end

    def empty(pid) do
        GenServer.cast(pid, :remove)
    end

    def stop(pid) do
        GenServer.stop(pid,:normal,:infinity)
    end

    #server
    
    def terminate(_reason, map) do
        IO.puts("Process Sali terminated. The map is:")
        IO.inspect(map)
        :ok
    end
    def handle_cast(:remove, _map) do
        updated_map = Map.new()
        {:noreply, updated_map}
    end
    
    def handle_cast({date,time}, map) do
        updated_map = Map.merge(map,Saliprogram.sali(date,time))
        {:noreply, updated_map}
    end
    
    def handle_call(:view, _from, map) do
        {:reply, map, map}
    end
    def init(map) do
        {:ok, map}
    end    

end


defmodule Saliprogram do
    use Agent
    def sali(data_film, ora_film) do #Saliprogram.sali("02.02.2019","21:00") - toate filmele care ruleaza la data si ora aia
        Saliprogram.start
        Saliprogram.update_sali(data_film, ora_film)
        Saliprogram.value
    end

    def start do
        Agent.start_link(fn -> %{} end, name: __MODULE__)
    end

    def update_sali(data_film, ora_film) do
        list = Database.read
        Enum.each list, fn(list) -> 
            if list.data == data_film and list.ora == ora_film do
                Saliprogram.update_agent_sali(list.sala, list.titlu) 
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

end