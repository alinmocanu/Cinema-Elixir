defmodule Program do
    use Agent

    def start_link do
        File.open("lib/Program.txt")
        Agent.start_link(fn -> elem(File.read("lib/Program.txt"),1) end, name: __MODULE__)
    end
    
    def value do
        Agent.get(__MODULE__, & IO.puts &1)
    end

    def write do

        Agent.update(__MODULE__,&(&1 = elem(File.read("lib/Program.txt"),1)))
    end

    #imi afiseaza la consola iex ce are fisierul
    def read do
        {:ok,contents} = File.read("lib/Program.txt")
        IO.puts contents
    end

    def do_stuff do
        Program.start_link #deschide agentul
        Program.write #actualizeaza programul
        Program.value #afiseaza programul la consola
    end
end

# Program.start_link(0)

# Program.value     #=> 0
# Program.increment #=> :ok
# Program.increment #=> :ok
# Program.value     #=> 2