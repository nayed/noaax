defmodule Noaax.Output do
  use Format

  @moduledoc """
  Format the data
  """

  @kv [{"weather", "Weather"}, {"temperature_string", "Temperature"},
       {"dewpoint_string", "Dewpoint"}, {"relative_humidity", "Relative Humidity"},
       {"heat_index_string", "Heat Index"}, {"wind_string", "Wind"},
       {"visibility_mi", "Visibility"}, {"pressure_string", "MSL Pressure"},
       {"pressure_in", "Altimeter"}]
  
  @doc """
  Output the result of fetching data from a NOAA station
  """
  def print(data) do
    Bunt.puts [:gold, retrieve(data, "location")]
    IO.puts retrieve(data, "observation_time")
    IO.puts ""

    Enum.each @kv, fn({k, v}) ->
      value_bright = Bunt.format [:bright, retrieve(data, k)]
      IO.puts Format.string(~F"{0: <20} | {1}", [v, value_bright])
    end
  end
  
  @doc """
  Get a list of data from a NOAA station and retrieve the value from the key
  """
  def retrieve(data, key) do
    string_data =
      unless Enum.empty? Floki.find(data, key) do
        {_, _, str_data} = Floki.find(data, key) |> List.last
        str_data
        else
          "No data available"
      end

    string_data
  end
  
  @doc """
  Export @kv constants for tests
  """
  def kv, do: @kv
end
