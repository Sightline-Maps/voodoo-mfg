defmodule Voodoo.Util do
  @moduledoc """
  Utilities library for Voodoo
  """

  # process voodoo response
  def handle_voodoo_response(res) do
    cond do
      res["error"] -> {:error, res}
      res["data"] -> {:ok, res}
      true -> {:ok, res}
    end
  end
end
