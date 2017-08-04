defmodule Noaax.CLI do
  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a table
  """

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be:
      -h or --help, which returns :help.
      -s or --state STATE, which returns list of station from STATE.
      -v or --version, which returns the app version

  Otherwise it is an existing NOAA station.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv,
                               switches: [ help: :boolean, state: :boolean, statename: :string, version: :boolean ],
                               aliases: [ h: :help, s: :state, t: :statename, v: :version ])

    case parse do
      { [ version: true ], _, _ } -> :version
      { [ help: true ], _, _ } -> :help
      { [ state: true ], _, _ } -> :help
      { [ state: true, statename: statename ], _, _ } -> { :state, statename }
      { _, [ station ], _ } -> station
      _ -> :help
    end
  end
  
  def process(:version) do
    {:ok, version} = :application.get_key(:noaax, :vsn)

    Bunt.puts [:bright, "Noaax version " <> List.to_string(version)]

    System.halt(0)
  end

  def process(:help) do
    Bunt.puts [:bright, "
    Usage: noaax <station>"
    ]
    Bunt.puts [:color156, "
    Options:
    -t, --state       show stations available in the state

    -h, --help        show this help message and exit
    -v, --version     show noaax version number and exit
    "]
    
    System.halt(0)
  end

  def process({:state, statename}) do
    Noaax.StateStation.fetch(statename)
  end

  def process(station) when is_binary(station) do
    Noaax.NoaaService.fetch(station)
  end

  def process(_), do: process(:help)
end
