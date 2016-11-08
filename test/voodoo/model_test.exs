defmodule Voodoo.ModelTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Voodoo

  import Voodoo.Model

  @tag timeout: 300000
  test "get model id" do
    use_cassette "get model id" do
      params = %{file_url: "https://s3-us-west-2.amazonaws.com/sightline-maps-static-assets/demo.stl"}
      {:ok, resp} = id(params)
      assert %{
        "file_bucket" => "repaired-models",
        "file_key" => _,
        "file_uri" => "repaired-models",
        "id" => _id,
        "notes" => nil,
        "rendering_url" => nil,
        "surface_area" => 200797.360817945,
        "volume" => 930583.831250032,
        "x" => 299,
        "y" => 289,
        "z" => 38.2941093444824} = resp
    end
  end

  @tag skip: "API server needs to accept POST requests or query parameters for GET"
  test "get the quote for a model" do
    use_cassette "get the quote for a model" do
      params = %{model_id: 1905,
                 units: "cm",
                 material_id: 1,
                 qty: 1}
      {:ok, resp} = get_quote(params)
      # TODO: Keep getting a Bad Request. Contacted Voodoo to verify if it's
      # a bug in their API server
      assert resp == %{}
    end
  end

  test "get model quote with attributes" do
    use_cassette "get model quote with attributes" do
      params = %{x: 15,
                 y: 22,
                 z: 23,
                 surface_area: 100,
                 volume: 200,
                 material_id: 7,
                 units: "cm",
                 quantity: 1}
      {:ok, resp} = quote_with_attributes(params)
      assert resp == %{
        "material_id" => 7,
        "quantity" => 1,
        "quote" => 34,
        "total" => 34,
        "unit_cost" => 34,
        "units" => "cm"
      }
    end
  end
end
