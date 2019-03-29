defmodule CinemaElixir do
  use Application
  @moduledoc """
  Documentation for CinemaElixir.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CinemaElixir.hello()
      :world

  """
  def start(_type,_args) do
    IO.puts "Cinema Elixir started"
    children = []
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def hello do
    :world
  end
end

