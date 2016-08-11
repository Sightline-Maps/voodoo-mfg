defmodule VoodooTest do
  use ExUnit.Case
  doctest Voodoo

  import Voodoo
  alias Voodoo.MissingSecretKeyError

  @secret_key "secret_key"
  @api_host "http://foo.com"

  setup do
    Application.put_env(:voodoo_mfg, :secret_key, @secret_key)
    Application.put_env(:voodoo_mfg, :api_host, @api_host)
    HTTPoison.start
    :ok
  end

  describe "secret_key/0" do

    test "fails when config for key is not set" do
      Application.delete_env(:voodoo_mfg, :secret_key)
      assert_raise MissingSecretKeyError, fn ->
        secret_key
      end
    end

    test "returns key when it is set in config" do
      assert secret_key == @secret_key
    end
  end

  describe "api_host/0" do

    test "fails when config for key is not set" do
      Application.delete_env(:voodoo_mfg, :api_host)
      assert_raise MissingSecretKeyError, fn ->
        api_host
      end
    end

    test "returns key when it is set in config" do
      assert api_host == @api_host
    end
  end

  test "process_url/1 attaches base url to endpoint" do
    assert process_url("/api") == "http://foo.com/api"
    assert process_url("api") == "http://foo.com/api"
  end

  test "process_request_body/1 returns json" do
    body = %{foo: "bar"}
    assert Poison.encode!(body) == process_request_body(body)
  end

  test "process_request_headers/0 sets key and content-type headers" do
    headers = process_request_headers
    assert {"key", @secret_key} in headers
    assert {"content-type", "application/json"} in headers
  end
end
