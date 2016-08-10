defmodule Voodoo.Order do
  @moduledoc """
  Handle orders for Voodoo Mfg
  (https://github.com/oortlieb/voodoo-api#api-endpoints)
  """

  @endpoint "/order"

  @doc """
  Get a direct print redirect url

  ## Examples

  params = %{
              file_url: "http://website.com/file.stl",
              material_id: 7,
              quantity: 1
            }

  {:ok, result} = Voodoo.Order.direct_print(params)
  """
  def direct_print(params) do
    url = @endpoint <> "/direct-print"
    body = params

    Voodoo.make_request(:get, url, body)
    |> Voodoo.Util.handle_voodoo_response
  end

  @doc """
  Get shipping rates

  ## Examples

  params = %{models: [
                %{material_id: 7,
                model_id: 1696,
                qty: 1,
                units: "mm"}
              ],
              shipping_info: %{
                city: "foo",
                name: "bar",
                zip: "12345",
                street1: "123 foo st",
                street2: "#1",
                state: "CA",
                country: "USA"
              }
            }

  {:ok, result} = Voodoo.Order.shipping_rates(params)
  """
  def shipping_rates(params) do
    url = @endpoint <> "/shipping"
    body = params

    Voodoo.make_request(:post, url, body)
    |> Voodoo.Util.handle_voodoo_response
  end

  @doc """
  Create an order

  ## Examples

  params = %{models: [
              %{material_id: 44,
                model_id: 1693,
                qty: 1,
                units: "mm"}
              ],
             shipment_id: "rate_0b011e90eb824e8ab72cbae2e4b7dda9"
            }

  {:ok, result} = Voodoo.Order.create(params)
  """
  def create(params) do
    url = @endpoint <> "/create"
    body = params

    Voodoo.make_request(:post, url, body)
    |> Voodoo.Util.handle_voodoo_response
  end

  @doc """
  Get confirmation of order

  ## Examples

  params = %{quote_id: "f02af79251d5018ac7afeba4e3bc1dd34ee1fdc6f12a883a23a6f317eff77ddf"}

  {:ok, result} = Voodoo.Order.confirm(params)
  """
  def confirm(params) do
    url = @endpoint <> "/confirm"
    body = params

    Voodoo.make_request(:post, url, body)
    |> Voodoo.Util.handle_voodoo_response
  end

end
