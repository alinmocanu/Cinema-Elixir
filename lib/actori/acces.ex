defmodule AccesGuard do
    def create(nume) do
        pid = spawn(AccesGuard, :init, [nume])
        Process.register(pid, :acces_guard)

    end

    def control(bilet, nume) do
        client = Process.whereis(String.to_atom(nume))
        if bilet == 1 do
            IO.puts("Vizionare placuta!")
        else
            IO.puts("Nu exista bilet!")
            send(client, {bilet})
        end
    end

    def init(nume) do
        receive do 
            {bilet, nume} -> control(bilet, nume)
        end
        init(nume)
    end
end
