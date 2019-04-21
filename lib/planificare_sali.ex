
defmodule PlanificareSali do
    use GenServer
  
    def start_link do
      GenServer.start_link(PlanificareSali,"Hello")
    end
  
    def init(initial_data) do
        IO.puts "PlanificareSali initialised"
      greetings = %{:greeting => initial_data}
      {:ok,greetings}
    end
  
  
    def handle_call(:pop, _from, my_state) do
      {:reply, my_state, my_state}
    end

    def handle_cast({:push,item},state) do
        {:noreply,[item|state]}
    end
  end

#start the server
  {:ok, pid} = GenServer.start_link(PlanificareSali, [:hello])

#this is the client
GenServer.call(pid,:pop) #:hello

GenServer.cast(pid,{:push,:world}) #:ok

GenServer.call(pid,:pop) #:world