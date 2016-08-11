defmodule Voodoo.Material do
  @moduledoc """
  Get list of available materials
  """

  @endpoint "/materials"

  @doc """
  Get list of materials from Voodoo

  ## Examples

  ```elixir
  {:ok, result} = Voodoo.Material.list
  ```
  """
  def list do
    Voodoo.make_request(:get, @endpoint)
    |> Voodoo.Util.handle_voodoo_response
  end
end
