defmodule Noaax.Mixfile do
  use Mix.Project

  def project do
    [
      app: :noaax,
      escript: escript_config(),
      name: "Noaax",
      source_url: "https://github.com/nayed/noaax",
      version: "0.1.0",
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:earmark, "~> 1.2"},
      {:ex_doc, "~> 0.16.2"},
      {:httpoison, "~> 0.12"},
      {:inch_ex, "~> 0.5", only: :docs},
      {:poison, "~> 3.1"}
    ]
  end

  defp escript_config do
    [
      main_module: Noaax.CLI,
      path: "bin/noaax"
    ]
  end
end
