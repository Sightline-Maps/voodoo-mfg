defmodule Voodoo.Mixfile do
  use Mix.Project

  def project do
    [app: :voodoo_mfg,
     version: "0.1.0",
     elixir: "~> 1.3",
     description: "An HTTP client for Voodoo Manufacturing",
     license: "MIT",
     contributors: "Sam Corcos",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [
      :httpoison,
      :logger
    ]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poison, "~> 2.0"},
      {:httpoison, "~> 0.9.0"}
    ]
  end
end
