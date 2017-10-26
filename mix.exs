defmodule Mappable.Mixfile do
  use Mix.Project

  @version "0.2.0"

  def project do
    [
      app: :mappable,
      description: "Convert different mappable types to each other in Elixir",
      version: @version,
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      name: "Mappable",
      package: package(),
      docs: [
        source_ref: "v#{@version}",
        main: "readme",
        source_url: "https://github.com/amberbit/mappable",
        extras: ["README.md"]
      ],
      deps: deps()
    ]
  end

  def package do
    [
      maintainers: ["Hubert Łępicki"],
      licenses: ["New BSD"],
      links: %{"GitHub" => "https://github.com/amberbit/mappable"}
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    []
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev}
    ]
  end
end
