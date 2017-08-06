defmodule Noaax.Mixfile do
  use Mix.Project
  
  @version "0.1.0"

  def project do
    [
      app: :noaax,
      escript: escript_config(),
      name: "Noaax",
      source_url: "https://github.com/nayed/noaax",
      version: @version,
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [ :logger, :httpoison, :bunt ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bunt, "~> 0.2.0"},
      {:earmark, "~> 1.2"},
      {:ex_doc, "~> 0.16.2"},
      {:floki, "~> 0.17.0"},
      {:httpoison, "~> 0.12"},
      {:inch_ex, "~> 0.5", only: :docs},

      {:format, git: "https://github.com/michalmuskala/format.git"},
    ]
  end

  defp escript_config do
    [
      main_module: Noaax.CLI,
      path: "bin/noaax"
    ]
  end
end
