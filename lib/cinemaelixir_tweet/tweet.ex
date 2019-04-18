defmodule CinemaElixir.Tweet do
    def send(text) do
      ExTwitter.update(text)
    end
end