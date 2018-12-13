defmodule Base62UUIDField.MixProject do
  use Mix.Project

  @version "1.0.0"
  @github_url "https://github.com/jclem/base62_uuid_field"

  def project do
    [
      app: :base62_uuid_field,
      description: "An Ecto type for Base62-encoded UUIDs",
      version: @version,
      package: package(),
      name: "Base62UUIDField",
      homepage_url: @github_url,
      source_url: @github_url,
      docs: docs(),
      elixir: "~> 1.3",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test,
        "coveralls.json": :test,
        "coveralls.post": :test,
        "coveralls.travis": :test
      ],
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
      {:base62_uuid, "~> 2.0.0"},
      {:ecto, "~> 3.0.5"},
      {:ex_doc, "~> 0.19.1", only: [:dev]},
      {:excoveralls, "~> 0.10.3", only: [:test]}
    ]
  end

  defp package do
    [
      name: :base62_uuid_field,
      licenses: ["MIT"],
      maintainers: ["Jonathan Clem <jonathan@jclem.net>"],
      links: %{"GitHub" => @github_url}
    ]
  end

  defp docs do
    [extras: ~w(LICENSE.md), main: "Base62UUIDField", source_ref: "v#{@version}"]
  end
end
