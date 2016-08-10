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
    Voodoo.make_request(:post, @endpoint, %{"file_url" => "https://s3-us-west-2.amazonaws.com/sightline-maps-static-assets/demo.stl"}, [{:timeout, 60000}])
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
    Voodoo.make_request(:get, @endpoint <> "/quote", {})
  end

  @doc """
  Gets the quote for a model with the given attributes.

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

    {:ok, result} = Voodoo.Model.quote_with_attributes
  """
  def quote_with_attributes(x, y, z, surface_area, volume, material_id, units, quantity) do

  end
end
