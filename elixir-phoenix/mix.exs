defmodule Minimal.MixProject do
  use Mix.Project

  def project do
    [
      app: :minimal,
      version: "0.1.0",
      deps: [
        {:jason, "~> 1.2"},
        {:phoenix, "~> 1.7"},
        {:plug_cowboy, "~> 2.0"}
      ]
    ]
  end

  def application do
    [mod: {Minimal.Application, []}]
  end
end
