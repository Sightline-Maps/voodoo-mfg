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
      assert resp == %{
        "file_bucket" => "repaired-models",
        "file_key" => "6f15faa7/aeb6/4fa9/ae99/5e92949e58ec/demo.stl",
        "file_uri" => "repaired-models", "id" => 1907, "notes" => nil,
        "surface_area" => 200797.360817945, "volume" => 930583.831250032,
        "x" => 299, "y" => 289, "z" => 38.2941093444824}
    end
  end

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
      assert resp == %{}
    end
  end
end
