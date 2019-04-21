defmodule Sali do
    use GenServer    
    
    def do_stuff do
        Sali.start
        Sali.add("02.02.2019","21:00")
        Sali.view
        Sali.stop
        #Process.alive?(pid)
    end
    #client
    def start do #runs in the caller context client
        GenServer.start_link(__MODULE__,%{}, name: :sali_server)
    end
    
    def add(date,time) do
        GenServer.cast(:sali_server, {date,time})
    end

    def view do
        GenServer.call(:sali_server, :view)
    end

    def empty do
        GenServer.cast(:sali_server, :remove)
    end

    def stop do
        GenServer.stop(:sali_server,:normal,:infinity)
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
        updated_map = Map.merge(map,SaliProgram.sali(date,time))
        {:noreply, updated_map}
    end
    
    def handle_call(:view, _from, map) do
        {:reply, map, map}
    end
    def init(map) do
        {:ok, map}
    end    

end
