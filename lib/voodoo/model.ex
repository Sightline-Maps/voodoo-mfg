defmodule Voodoo.Model do
  @moduledoc """
  Get model estimate or model id
  """

  @endpoint "/model"

  @doc """
  Get model id

  ## Examples

  ```elixir
  {:ok, result} = Voodoo.Model.id
  ```
  """
  def id do
    Voodoo.make_request(:post, @endpoint, {"file_url", "https://s3-us-west-2.amazonaws.com/sightline-maps-static-assets/demo.stl"})
    |> Voodoo.Util.handle_voodoo_response
  end

end
#
#
# defmodule Voodoo.Material do
#   @moduledoc """
#   Get list of available materials
#   """
#
#   @endpoint "/materials"
#
#   @doc """
#   Get list of materials from Voodoo
#
#   ## Examples
#
#   ```elixir
#   {:ok, result} = Voodoo.Material.list
#   ```
#   """
#   def list do
#     Voodoo.make_request(:get, @endpoint)
#     |> Voodoo.Util.handle_voodoo_response
#   end
# end
