defmodule Voodoo.UtilTest do
  use ExUnit.Case

  import Voodoo.Util

  test "handle_voodoo_response/1" do
    resp = %HTTPoison.Response{
      status_code: 400,
      body: "Plain text",
      headers: [{"Content-Type", "text/plain"}]}
    {:ok, result} = handle_voodoo_response({:ok, resp})
    assert result == "Plain text"

    json_body = Poison.encode!(%{foo: "bar"})
    resp = %{resp| headers: [{"Content-Type", "application/json"}], body: json_body}
    {:ok, result} = handle_voodoo_response({:ok, resp})
    assert result == %{"foo" => "bar"}

    resp = {:error, %{reason: "Invalid Request"}}
    result = handle_voodoo_response(resp)
    assert {:error, "Invalid Request"} = result
  end

  test "prepare_params/1" do
    result = prepare_params(%{foo: "bar"})
    assert result == [params: [{"foo", "bar"}]]
  end
end
