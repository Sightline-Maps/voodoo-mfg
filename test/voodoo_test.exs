defmodule VoodooTest do
  use ExUnit.Case
  doctest Voodoo

  import Voodoo
  alias Voodoo.MissingSecretKeyError

  @secret_key "secret_key"
  @api_host "http://foo.com"

  describe "secret_key/0" do

    test "fails when config for key is not set" do
      old_secret_key = Application.get_env(:voodoo_mfg, :secret_key)
      Application.delete_env(:voodoo_mfg, :secret_key)
      assert_raise MissingSecretKeyError, fn ->
        secret_key
      end
      Application.put_env(:voodoo_mfg, :secret_key, old_secret_key)
    end

    test "returns key when it is set in config" do
      old_secret_key = Application.get_env(:voodoo_mfg, :secret_key)
      Application.put_env(:voodoo_mfg, :secret_key, @secret_key)
      assert secret_key == @secret_key
      Application.put_env(:voodoo_mfg, :secret_key, old_secret_key)
    end
  end

  describe "api_host/0" do

    test "fails when config for key is not set" do
      old_host = Application.get_env(:voodoo_mfg, :api_host)
      Application.delete_env(:voodoo_mfg, :api_host)
      assert_raise MissingSecretKeyError, fn ->
        api_host
      end
      Application.put_env(:voodoo_mfg, :api_host, old_host)
    end

    test "returns key when it is set in config" do
      old_host = Application.get_env(:voodoo_mfg, :api_host)
      Application.put_env(:voodoo_mfg, :api_host, @api_host)
      assert api_host == @api_host
      Application.put_env(:voodoo_mfg, :api_host, old_host)
    end
  end

  test "process_url/1 attaches base url to endpoint" do
    assert process_url("/test") == "https://staging-api.voodoomfg.com/api/1/test"
    assert process_url("test") == "https://staging-api.voodoomfg.com/api/1/test"
  end

  test "process_request_body/1 returns json" do
    body = %{foo: "bar"}
    assert Poison.encode!(body) == process_request_body(body)
  end
end
