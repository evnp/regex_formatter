defmodule RegexFormatter.MixProject do
  use Mix.Project

  @name "RegexFormatter"
  @version "0.1.1"
  @repository "https://github.com/evnp/regex_formatter"

  defp description() do
    "Don't fear the regex. Malleable 'mix format' via powerful code-search/replace."
  end

  def project() do
    [
      app: :regex_formatter,
      description: description(),
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      package: package(),
      docs: docs(),
      deps: deps(),

      # Docs (see https://github.com/elixir-lang/ex_doc)
      name: @name,
      source_url: @repository,
      homepage_url: @repository
    ]
  end

  defp package() do
    [
      maintainers: ["Evan Campbell Purcer"],
      licenses: ["MIT"],
      links: %{"GitHub" => @repository}
    ]
  end

  defp docs() do
    [
      main: "readme",
      logo: "regex_formatter.png",
      extras: ["README.md"]
    ]
  end

  defp deps() do
    [
      {:ex_doc, "~> 0.34", only: :dev, runtime: false},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end

  def application() do
    []
  end
end
