defmodule Voodoo.Model do
  @moduledoc """
  Get model estimate or model id
  """

  @endpoint "/model"

  @doc """
  Get model id

  *Note that this process can take a long time. The timeout is set to 5 minutes.*

  ## Examples

  ```elixir
  {:ok, result} = Voodoo.Model.id(
                 %{file_url: "https://s3-us-west-2.amazonaws.com/sightline-maps-static-assets/demo.stl"})
  ```
  """
  def id(params) do
    opts = [timeout: 300000, recv_timeout: 300000]
    body = params

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

  {:ok, result} = Voodoo.Model.quote(
                  %{model_id: 1234,
                    units: "cm",
                    material_id: 7,
                    qty: 1})
  """
  def quote(params) do
    url = @endpoint <> "/quote"
    body = params

    Voodoo.make_request(:get, url, body)
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
    body = params
    url = @endpoint <> "/quote/attributes"

    Voodoo.make_request(:get, url , body)
    |> Voodoo.Util.handle_voodoo_response
  end
end
