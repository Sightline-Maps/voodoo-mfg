defmodule VoodooTest do
  use ExUnit.Case
  doctest Voodoo

  import Voodoo
  alias Voodoo.MissingSecretKeyError

  describe "config_or_env_key/0" do

    test "fails when config for key is not set" do
      assert_raise MissingSecretKeyError, fn ->
        config_or_env_key
      end
    end

    test "returns key when it is set in config" do
      Application.put_env(:voodoo_mfg, :secret_key, "secret_key")
      assert config_or_env_key == "secret_key"
      Application.put_env(:voodoo_mfg, :secret_key, nil)
    end
  end

  describe "config_or_env_host/0" do

    test "fails when config for key is not set" do
      assert_raise MissingSecretKeyError, fn ->
        config_or_env_host
      end
    end

    test "returns key when it is set in config" do
      Application.put_env(:voodoo_mfg, :api_host, "http://foo.com")
      assert config_or_env_host == "http://foo.com"
      Application.put_env(:voodoo_mfg, :api_host, nil)
    end
  end
end
