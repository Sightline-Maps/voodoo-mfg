defmodule Voodoo.Util do
  @moduledoc """
  Utilities library for Voodoo
  """

  # process voodoo response
  def handle_voodoo_response(res) do
    case res do
      {:error, error} -> {:error, error.reason}
      {:ok, res} -> Poison.decode(res.body)
    end
  end
end
