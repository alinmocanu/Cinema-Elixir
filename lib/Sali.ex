defmodule Sali do
    use GenServer
    #client
    def start_link do #runs in the caller context client
        GenServer.start_link(__MODULE__,[])
    end
    
    def add(pid, item) do
        GenServer.cast(pid, item)
    end

    def view(pid) do
        GenServer.call(pid, :view)
    end

    def remove(pid, item) do
        GenServer.cast(pid, {:remove, item})
    end

    def stop(pid) do
        GenServer.stop(pid,:normal,:infinity)
    end

    #server
    
    def terminate(_reason, list) do
        IO.puts("We are all done shopping.")
        IO.inspect(list)
        :ok
    end
    def handle_cast({:remove, item}, list) do
        updated_list = Enum.reject(list, fn(i) -> i == item end)
        {:noreply, updated_list}
    end
    
    def handle_cast(item, list) do
        updated_list = [item|list]
        {:noreply, updated_list}
    end
    
    def handle_call(:view, _from, list) do
        {:reply, list, list}
    end
    def init(list) do
        {:ok, list}
    end

    def do_stuff do
        _data = Database.read
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