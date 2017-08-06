defmodule Noaax.Output do
  use Format

  @moduledoc """
  Format the data
  """

  def print(data) do
    keys = ["weather", "temperature_string", "dewpoint_string",
            "relative_humidity", "heat_index_string", "wind_string",
            "visibility_mi", "pressure_string", "pressure_in"]
    
    display = ["Weather", "Temperature", "Dewpoint",
               "Relative Humidity", "Heat Index", "Wind",
               "Visibility", "MSL Pressure", "Altimeter"]
    
    kv = Enum.zip keys, display
    
    Bunt.puts [:gold, retrieve(data, "location")]
    IO.puts retrieve(data, "observation_time")
    IO.puts ""

    Enum.each kv, fn({k, v}) ->
      value_bright = Bunt.format [:bright, retrieve(data, k)]
      IO.puts Format.string(~F"{0: <20} | {1}", [v, value_bright])
    end
  end

  def retrieve(data, key) do
    {_, _, string_data} = Floki.find(data, key) |> List.last
    string_data
  end
end
