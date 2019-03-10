defmodule EnCli.MixProject do
  use Mix.Project

  def project do
    [
      app: :en_cli,
      version: "0.2.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
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
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.5"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false},
      {:exvcr, "~> 0.10", only: :test},
    ]
  end

  defp description do
    """
    API wrapper for engima
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Sergio 'itSQualL' Ruiz"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/itsquall/en_cli"}
    ]
  end
end
