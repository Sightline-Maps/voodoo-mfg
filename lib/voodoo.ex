defmodule Voodoo do
  @moduledoc """
   An HTTP client for Voodoo Manufacturing
  https://www.voodoomfg.com

  ## Configuration
  """
  use HTTPoison.Base

  @doc """
  Grab VOODOO_SECRET_KEY
  """
  def config_or_env_key do
    require_voodoo_key
  end

  def config_or_env_host do
    require_voodoo_host
  end

  @doc """
  Create the base URL for the endpoint
  Args:
    * url - such as "/api"
  Returns string
  """
  def process_url(url) do
    Voodoo.config_or_env_host <> url
  end

  @doc """
  Process request body and convert to escaped json string
  Accepts a map
  """
  def process_request_body(body) do
    Poison.encode! body
  end

  @doc """
  Set request headers and format
  """
  def req_headers do
    Map.new
      |> Map.put("key", Voodoo.config_or_env_key)
      |> Map.put("content-type",  "application/json")
      |> Map.to_list
  end

  defmodule MissingSecretKeyError do
    defexception message: """
      The secret_key setting is required so that we can report the
      correct environment instance to Voodoo Mfg. Please configure
      secret_key in your config.exs and environment specific config files
      to have accurate reporting of errors.

      config :voodoo_mfg,
        secret_key: <VOODOO_SECRET_KEY>,
        api_host: <VOODOO_HOST>
    """
  end

  defmodule MissingAPIHostError do
    defexception message: """
      The api_host setting is required so that we can report the
      correct environment instance to Voodoo Mfg. Please configure
      api_host in your config.exs and environment specific config files
      to have accurate reporting of errors.

      config :voodoo_mfg,
        secret_key: <VOODOO_SECRET_KEY>,
        api_host: <VOODOO_HOST>
    """
  end

  @doc """
  Makes request to Voodoo using HTTPoison `request`
  (https://hexdocs.pm/httpoison/HTTPoison.html#request/5)

  Args:
    * method - request method (post, get, etc)
    * endpoint - api endpoint (/order, /material, etc)
    * body - request body
    * options - request options
  """
  def make_request(method, url, body \\ %{}, options \\ []) do
    headers = req_headers
    {:ok, response} = request(method, url, body, headers, options)
  end

  defp require_voodoo_key do
    case Application.get_env(:voodoo_mfg, :secret_key, System.get_env "VOODOO_SECRET_KEY") || :not_found do
      :not_found ->
        raise MissingSecretKeyError
      value -> value
    end
  end

  defp require_voodoo_host do
    case Application.get_env(:voodoo_mfg, :api_host, System.get_env "VOODOO_API_HOST") || :not_found do
      :not_found ->
        raise MissingAPIHostError
      value -> value
    end
  end
end
