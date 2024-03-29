defmodule Base62UUIDField.MixProject do
  use Mix.Project

  @version "2.0.0"
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
      elixir: "~> 1.7",
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
      {:base62_uuid, "~> 3.0.0"},
      {:ecto, "~> 3.0"},
      {:ex_doc, "~> 0.28.0", only: [:dev]},
      {:excoveralls, "~> 0.14.4", only: [:test]}
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
    [extras: ~w(README.md LICENSE.md), main: "readme", source_ref: "v#{@version}"]
  end
end
