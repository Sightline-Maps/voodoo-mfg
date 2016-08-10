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
    opts = [timeout: 100000, recv_timeout: 100000]
    body = %{"file_url" => "https://s3-us-west-2.amazonaws.com/sightline-maps-static-assets/demo.stl"}
    Voodoo.make_request(:post, @endpoint, body, opts)
    |> Voodoo.Util.handle_voodoo_response
  end

  @doc """
  Get the quote for a single model file for a given quantity,
  material, and unit scale.

  Args:
    * model_id - integer
    * units - binary, ("mm", "cm", "in")
    * material_id - integer from Voodoo.Material.list
    * qty - integer

  ## Examples

  {:ok, result} = Voodoo.Model.quote
  """
  def quote(model_id, units, material_id, qty) do
    Voodoo.make_request(:get, @endpoint <> "/quote",
    %{"model_id" => model_id,
      "units" => units,
      "material_id" => material_id,
      "qty" => qty})
    |> Voodoo.Util.handle_voodoo_response
  end

  @doc """
  Gets the quote for a model with the given attributes.

  Takes in a map with the following arguments.

  Args:
    * x - integer for bounding box x
    * y - integer for bounding box y
    * z - integer for bounding box z
    * surface_area - integer
    * volume - integer
    * material_id - integer
    * units - binary ("mm", "cm", "in")
    * quantity - integer

    ## Examples

    {:ok, result} = Voodoo.Model.quote_with_attributes(
                    %{x: 15,
                      y: 22,
                      z: 23,
                      surface_area: 100,
                      volume: 200,
                      material_id: 7,
                      units: "cm",
                      quantity: 1})
  """
  def quote_with_attributes(params) do
    Voodoo.make_request(:get, @endpoint <> "/quote/attributes",
    %{x: params.x,
      y: params.y,
      z: params.z,
      surface_area: params.surface_area,
      volume: params.volume,
      material_id: params.material_id,
      units: params.units,
      quantity: params.quantity})
    |> Voodoo.Util.handle_voodoo_response
  end
end
