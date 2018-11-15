defmodule CrawlerElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :crawler_elixir,
      version: "0.1.0",
      elixir: "~> 1.7",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      escript: [main_module: CrawlerElixir],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:exjsx, "~> 4.0.0"}
    ]
  end
end
