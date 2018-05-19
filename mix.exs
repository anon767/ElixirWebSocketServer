defmodule Tom.GameServer do
  use Mix.Project

def project do
            [app: :gameServer,
            version: "0.0.1",
                      deps: deps(),
            package: package(),
            description: "Generic Communication Server for .io games",
            escript: [main_module: GameServer]]
            end

# Configuration for the OTP application
def application do
  [applications: [:crypto, :ssl]]
end

def escript do # define escript
  [main_module: GameServer]
end

defp deps do
  [{:ex_doc, "~> 0.18", only: [:dev]}, {:socket, "~> 0.3.13"}]
end

defp package do
  [
    maintainers: ["anon767"],
    licenses: ["WTFPL"]
  ]
end
end
