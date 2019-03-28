defmodule CinemaElixir do
  @moduledoc """
  Documentation for CinemaElixir.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CinemaElixir.hello()
      :world

  """
  def hello do
    :world
  end
end

defmodule PlanificareSali do
  use GenServer

  @spec start_link() :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link do
    GenServer.start_link(PlanificareSali,"Hello")
  end

  @spec init(any()) :: {:ok, any()}
  def init(initial_data) do
    greetings = %{:greeting => initial_data}
    {:ok,greetings}
  end

  @spec get_my_state(atom() | pid() | {atom(), any()} | {:via, atom(), any()}) :: any()
  def get_my_state(process_id) do
    GenServer.call(process_id,{:get_the_state})
  end

  def handle_call({:get_the_state}, _from, my_state) do
    {:reply, my_state, my_state}
  end
end