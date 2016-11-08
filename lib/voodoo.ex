defmodule Voodoo do
  @moduledoc """
  An HTTP client for Voodoo Manufacturing
  https://www.voodoomfg.com

  ## Configuration
  """

  alias Voodoo.Util

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
  def process_request_body(body) when is_map(body) do
    Poison.encode! body
  end
  def process_request_body(body), do: body

  @doc """
  Set request headers and format
  """
  def request_headers do
    [{"content-type", "application/json"},
     {"key", Voodoo.secret_key}]
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
  def make_request(method, path, body \\ "", options \\ []) do
    url = process_url(path)
    body = process_request_body(body)

    HTTPoison.request(method, url, body, request_headers, options)
    |> Util.handle_voodoo_response
  end
end
