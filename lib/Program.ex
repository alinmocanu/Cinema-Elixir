defmodule Program do
    use Agent

    def start_link() do
        #Agent.start_link(fn -> initial_value end, name: __MODULE__)
        #{:ok,file} = File.open("Program.txt",[:read,:compressed])
        File.open("Program.txt")
        Agent.start_link(fn -> File.read("Program.txt") end, name: __MODULE__)
    end
    
    def value do
        Agent.get(__MODULE__, & &1)
    end
    
    # def increment do
    #     Agent.update(__MODULE__, &(&1 + 1))
    # end

    def write do
        #base = File.read("Program.txt")
        Agent.update(__MODULE__,&(File.copy("Program.txt",&1)))
    end
end

# Program.start_link(0)

# Program.value     #=> 0
# Program.increment #=> :ok
# Program.increment #=> :ok
# Program.value     #=> 2