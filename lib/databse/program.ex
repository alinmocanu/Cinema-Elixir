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

    def read do
        {:ok,contents} = File.read("lib/Program.txt")
        IO.puts contents
    end

    def do_stuff do
        Program.start_link 
        Program.write 
        Program.value 
    end

    def time(0) do
        Program.do_stuff
    end

    def time(seconds) do 
        #IO.write("\r#{seconds}")
        Process.sleep(1000)
        time(seconds - 1)
    end

    def timer(seconds) do #asta apelam, timer(10) de exemplu
        time(seconds)
        timer(seconds)
    end
end
