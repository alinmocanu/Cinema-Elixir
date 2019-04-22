defmodule AccesGuard do
    def create(nume) do
        pid = spawn(AccesGuard, :init, [nume])
        Process.register(pid, :acces_guard)

    end

    def control(bilet, nume, varsta) do
        client = Process.whereis(String.to_atom(nume))
        if bilet <= varsta do
            IO.puts("Vizionare placuta!")
        else
            IO.puts("Ati fost identificat fraudand sistemul!")
            send(client, {bilet})
        end
    end

    def init(nume) do
        receive do 
            {bilet, nume, varsta} -> control(bilet, nume, varsta)
        end
        init(nume)
    end
end
