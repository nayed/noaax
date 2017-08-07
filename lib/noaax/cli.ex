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
      -s or --state <state>, which returns list of station from <state>.
      -h or --help, which returns :help.
      -v or --version, which returns the app version

  Otherwise it is an existing NOAA station.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv,
                               switches: [ help: :boolean, state: :string, version: :boolean ],
                               aliases: [ h: :help, s: :state, v: :version ])

    case parse do
      { [ version: true ], _, _ } -> :version
      { [ help: true ], _, _ } -> :help
      { [ state: state ], _, _ } -> { :state, state }
      { _, [ station ], _ } -> String.upcase station
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
    Usage: noaax <station>"]

    Bunt.puts [:color156, "
    Options:
    -s, --state <state>       show stations available in <state>"]

    IO.write "
        example:
        $ noaax -s ca         will display station available in California
    "
    Bunt.puts [:color156, "
    -h, --help                show this help message and exit
    -v, --version             show noaax version number and exit
    "]
    
    System.halt(0)
  end

  def process({:state, state}) do
    Noaax.NoaaService.fetch_list_station(state)
    |> decode_response
    |> Noaax.ListStations.print
  end

  def process(station) when is_binary(station) do
    Noaax.NoaaService.fetch(station)
    |> decode_response
    |> Noaax.Output.print
  end

  # def process(_), do: process(:help)
  
  def decode_response({:ok, body}), do: body
  def decode_response({:error, _error}) do
    IO.puts "Error fetching this station. Does it exists?"

    System.halt(0)
  end
end
