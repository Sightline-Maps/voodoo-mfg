defmodule Voodoo.Mixfile do
  use Mix.Project

  def project do
    [app: :voodoo_mfg,
     package: package(),
     version: "1.0.0",
     elixir: "~> 1.3",
     description: "An HTTP client for Voodoo Manufacturing",
     contributors: "Sam Corcos",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [
        vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test
      ],
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

  defp package do
    [ name: :voodoo_mfg,
      files: ["lib", "mix.exs", "README*"],
      licenses: ["MIT"],
      maintainers: ["Sam Corcos <sam@sightlinemaps.com>"],
      links: %{"GitHub" => "https://github.com/Sightline-Maps/voodoo-mfg",
               "Docs" => "https://github.com/Sightline-Maps/voodoo-mfg",
               "Sightline Maps" => "https://sightlinemaps.com",
               "Voodoo Manufacturing" => "https://voodoomfg.com"}]
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
      {:httpoison, "~> 0.9.0"},
      {:exvcr, "~> 0.7", only: :test}
    ]
  end
end
