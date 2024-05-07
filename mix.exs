defmodule Appipelago.MixProject do
  use Mix.Project

  @git_url "https://github.com/hungry-egg/appipelago"

  def project do
    [
      app: :appipelago,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Helpers for rendering components from front-end frameworks in Phoenix",
      package: package(),
      source_url: @git_url
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
      {:phoenix, ">= 1.4.0"},
      {:phoenix_live_view, ">= 0.18.0"},
      {:ex_doc, "~> 0.32.1", only: :dev, runtime: false},
      {:jason, "~> 1.4.1", only: :test},
      {:floki, "~> 0.36.2", only: :test}
    ]
  end

  defp package do
    [
      files: ~w(lib packages/core/dist package.json .formatter.exs mix.exs README.md LICENSE.txt),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @git_url}
    ]
  end
end
