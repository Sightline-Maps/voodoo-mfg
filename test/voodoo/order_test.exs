defmodule Voodoo.OrderTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Voodoo

  import Voodoo.Order

  test "direct-print returns a redirect url" do
    # https://github.com/oortlieb/voodoo-api#get-orderdirect-print
    use_cassette "get a direct print redirect url" do
      params = %{file_url: "http://website.com/file.stl",
                 material_id: 7,
                 quantity: 1}
      {:ok, resp} = direct_print(params)
      assert %{"redirect" => _} = resp
    end
  end

  test "create shipment for uploaded items" do
    # https://github.com/oortlieb/voodoo-api#post-ordershipping
    use_cassette "create shipment for uploaded items" do
      params = %{models: [%{
                  material_id: 7,
                  model_id: 4414,
                  quantity: 1,
                  units: "cm"}],
                shipping_address: %{
                  email: "test@voodoomfg.com",
                  city: "foo",
                  name: "bar",
                  zip: "12345",
                  street1: "123 foo st",
                  street2: "#1",
                  state: "CA",
                  country: "USA"}}
      {:ok, resp} = shipping_rates(params)
      assert resp == ""
    end
  end

  test "create order on the server" do
    # https://github.com/oortlieb/voodoo-api/blob/master/README.md#post-ordercreate
    use_cassette "create order on the server" do
      params = %{models: [
                %{material_id: 1,
                  model_id: 1905,
                  quantity: 1,
                  units: "mm"}],
                shipment_id: "rate_0b011e90eb824e8ab72cbae2e4b7dda9"}
      {:ok, resp} = create(params)
      assert resp == %{"due_date" => "2016-08-11T05:50:12.437Z",
              "order_items" => [%{"filename" => "demo.stl", "id" => 1905,
              "material_id" => 1, "qty" => 1, "units" => "mm"}],
              "quote" => %{"errors" => [],
                "extras" => [%{"name" => "production_option", "price" => 0}],
                "items" => 85.14, "shipping" => 7.22, "total" => 92.36},
              "quote_id" => "438f0e120a33eec2b312adcaf1d0dab3395a88c7bf8fa40203bb81ee261966c6",
              "shipping" => %{"delivery" => "rate_0b011e90eb824e8ab72cbae2e4b7dda9"}}
    end
  end

  test "confirm an order" do
    # https://github.com/oortlieb/voodoo-api/blob/master/README.md#post-orderconfirm
    use_cassette "confirm an order" do
      params = %{quote_id: "f02af79251d5018ac7afeba4e3bc1dd34ee1fdc6f12a883a23a6f317eff77ddf"}
      {:ok, resp} = Voodoo.Order.confirm(params)
      assert resp == ""
    end
  end
end
