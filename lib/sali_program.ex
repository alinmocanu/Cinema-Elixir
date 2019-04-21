defmodule SaliProgram do
    use Agent
    
    def sali(data_film, ora_film) do #Saliprogram.sali("02.02.2019","21:00") - toate filmele care ruleaza la data si ora aia
        SaliProgram.start
        SaliProgram.update_sali(data_film, ora_film)
        SaliProgram.value
    end

    def start do
        Agent.start_link(fn -> %{} end, name: __MODULE__)
    end

    def update_sali(data_film, ora_film) do
        list = Database.read
        Enum.each list, fn(list) -> 
            if list.data == data_film and list.ora == ora_film do
                SaliProgram.update_agent_sali(list.sala, list.titlu) 
            else
            end
        end
    end
    
    def update_agent_sali(sala, titlu) do        
        Agent.update(__MODULE__,fn(state) ->             
                Map.put(state,sala,titlu)                                   
        end)
    end

    def value do
        Agent.get(__MODULE__,fn(state) -> state end)
    end

end