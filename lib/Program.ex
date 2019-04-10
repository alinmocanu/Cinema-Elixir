defmodule Program do
    use Agent

    def start_link do
        #Agent.start_link(fn -> initial_value end, name: __MODULE__)
        #{:ok,file} = File.open("Program.txt",[:read,:compressed])
        File.open("lib/Program.txt")
        Agent.start_link(fn -> File.read("lib/Program.txt") end, name: __MODULE__)
    end
    
    def value do
        #Agent.get(__MODULE__, & &1)
        Agent.get(__MODULE__,fn(state) -> Map.get(state,1)end)
    end
    
    # def increment do
    #     Agent.update(__MODULE__, &(&1 + 1))
    # end

    def write do
        #base = File.read("Program.txt")
        #Agent.update(__MODULE__,&(File.copy("lib/Program.txt",&1)))
        Agent.update(__MODULE__,fn(state) -> Map.put(state,1,Program.read) end)
    end

    #imi afiseaza la consola iex ce are fisierul
    def read do
        {:ok,contents} = File.read("lib/Program.txt")
        contents
    end

    def do_stuff do
        {:ok,contents} = Program.start_link
        Program.write
        Program.value
    end
end

# Program.start_link(0)

# Program.value     #=> 0
# Program.increment #=> :ok
# Program.increment #=> :ok
# Program.value     #=> 2