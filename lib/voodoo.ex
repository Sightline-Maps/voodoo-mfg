defmodule Voodoo do
  @moduledoc """
  An HTTP client for Voodoo Manufacturing
  https://www.voodoomfg.com

  ## Configuration
  """
  use HTTPoison.Base

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
  Grab VOODOO secret_key set in config
  """
  def secret_key do
    Application.get_env(:voodoo_mfg, :secret_key) ||  raise MissingSecretKeyError
  end

  @doc """
  Grab Voodoo api_host set in config
  """
  def api_host do
    Application.get_env(:voodoo_mfg, :api_host) ||  raise MissingSecretKeyError
  end

  @doc """
  Create the base URL for the endpoint
  Args:
    * url - such as "/api"
  Returns string
  """
  def process_url(url) do
    Voodoo.api_host
    |> Path.join(url)
  end

  @doc """
  Process request body and convert to escaped json string
  Accepts a map
  """
  def process_request_body(body) do
    Poison.encode! body
  end

  @doc """
  Set request headers and format
  """
  def process_request_headers(_) do
    Map.new
    |> Map.put("key", Voodoo.secret_key)
    |> Map.put("content-type",  "application/json")
    |> Map.to_list
  end

  @doc """
  Makes request to Voodoo using HTTPoison `request`
  (https://hexdocs.pm/httpoison/HTTPoison.html#request/5)

  Args:
    * method - request method (post, get, etc)
    * endpoint - api endpoint (/order, /material, etc)
    * body - request body
    * options - request options
  """
  def make_request(method, url, body \\ %{}, options \\ []) do
    {:ok, _response} = request(method, url, body, [], options)
  end
end
