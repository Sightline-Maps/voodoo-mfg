defmodule Voodoo.ModelTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Voodoo

  import Voodoo.Model

  test "get the quote for a model" do
    use_cassette "get the quote for a model" do
      params = %{model_id: 1905,
                 units: "cm",
                 material_id: 1,
                 qty: 1}
      {:ok, resp} = get_quote(params)
      assert resp == ""
    end
  end
end
