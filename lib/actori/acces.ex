defmodule AccesGuard do
    def create(nume) do
        pid = spawn(AccesGuard, :init, [nume])
        Process.register(pid, :acces_guard)

    end

    def control(nume, prenume, bilet, varsta) do
        pid_name = nume<>prenume<>Integer.to_string(varsta)
        client = Process.whereis(String.to_atom(pid_name))
        if varsta >= bilet do
            IO.puts("Vizionare placuta, #{nume<>" "<>prenume}!")
        else
            IO.puts("#{nume<>" "<>prenume} ai fost identificat fraudand sistemul!")
            send(client, {bilet})
        end
    end

    def init(nume) do
        receive do 
            {nume, prenume, bilet, varsta} -> control(nume, prenume, bilet, varsta)
        end
        init(nume)
    end
end
