defmodule Noaax.ListStations do
  use Format

  @moduledoc """
  List station from a given state
  """
  
  @doc """
  """
  def print(data) do
    list_stations = Floki.find(data, "td[headers='Station Name']")
    
    array_stations = code_name(list_stations)
    
    code_bright = Bunt.format [:bright, "Code"]
    IO.puts Format.string(~F"{0: <15} | {1}", [code_bright, "Name"])
    Enum.each array_stations, fn ({k, v}) ->
      key_bright = Bunt.format [:bright, k]
      IO.puts Format.string(~F"{0: <15} | {1}", [key_bright, v])
    end
  end

  @doc """
  Receive a list, returns a list of tuples [{station_code, station_name}]
  ## Example
      iex> list = [
      ...>          {"td", [{"headers", "Station Name"}],
      ...>            [{"a", [{"href", "display.php?stid=KAAT"}], ["Alturas"]}, " (KAAT)"]},
      ...>          {"td", [{"headers", "Station Name"}],
      ...>            [{"a", [{"href", "display.php?stid=KACV"}], ["Arcata Airport"]}, " (KACV)"]}
      ...>        ]
      iex> Noaax.ListStations.code_name(list)
      [{"KAAT", "Alturas"}, {"KACV", "Arcata Airport"}]
  """
  def code_name(list) do
    Enum.map list, fn(x) ->
      {_, _, array} = x
      {_, _, station_name} = List.first(array)
      station_name = List.to_string(station_name)
      station_code = array |> List.last |> String.trim |> delete_parenthesis
      {station_code, station_name}
    end
  end
  
  @doc """
  Receive a string with parenthesis, returns a string without
  ## Examples
      iex> Noaax.ListStations.delete_parenthesis("(KJNU)")
      "KJNU"
      iex> Noaax.ListStations.delete_parenthesis("L56B")
      "L56B"
      
  """
  def delete_parenthesis(str) do
    Regex.scan(~r/[A-z0-9]/, str) |> List.flatten |> Enum.join
  end
end
