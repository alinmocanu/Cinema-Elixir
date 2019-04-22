defmodule Client1 do
    use Agent 

    def start(nume, prenume, bani, bilet, varsta) do
        Agent.start_link(fn->%{:nume => nume,
                               :prenume => prenume,
                               :bani => bani,
                               :bilet => bilet,
                               :varsta => varsta} end, name: :client)
    end

    def get do
        Agent.get(:client, fn(state) -> state end)
    end

    def update do
        suma = Map.get(Client1.get,:bani);
        suma = suma - 15;
        Agent.update(:client, fn(state)-> Map.update!(state, :bani, suma) end)
    end
end