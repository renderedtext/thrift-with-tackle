defmodule ElixirThrift.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_thrift,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     compilers: [:thrift | Mix.compilers],
     thrift_files: Mix.Utils.extract_files(["thrift"], [:thrift]),
     deps: deps()]
  end

  def application do
    [mod: {ElixirThrift, []},
      applications: [:logger,
        :tackle,
        :thrift_serializer
    ]]
  end

  defp deps do
    [ {:tackle, github: "renderedtext/ex-tackle"},
      {:thrift_serializer, github: "renderedtext/ex-thrift-serializer"} ]
  end
end
