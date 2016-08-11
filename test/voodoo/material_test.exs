defmodule Voodoo.MaterialTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Voodoo

  import Voodoo.Material

  test "get list of materials" do
    # https://github.com/oortlieb/voodoo-api/blob/master/README.md#get-materials
    use_cassette "get the list of materials" do
      {:ok, [first | _] = resp} = list()
      assert length(resp) == 35
      assert %{"color" => _, "color_sample" => _, "id" => 1, "type" => _} = first
    end
  end
end
