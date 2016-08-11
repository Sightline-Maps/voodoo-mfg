defmodule Voodoo.Util do
  @moduledoc """
  Utilities library for Voodoo
  """

  @doc """
  Return response body from an HTTPoison.Response struct
  """
  def handle_voodoo_response(res) do
    case res do
      {:error, error} ->
        {:error, error.reason}
      {:ok, %{headers: headers, body: body}} ->
        content_type = :proplists.get_value("Content-Type", headers)
        if match?("application/json" <> _, content_type) do
          Poison.decode(body)
        else
          {:ok, body}
        end
    end
  end

  @doc """
  Converts a map of params to a list of 2-element tuples that hackney
  expects.
  """
  def prepare_params(params) when is_map(params) do
    [params: Enum.map(params, fn {key, value} -> {"#{key}", value} end)]
  end
end
