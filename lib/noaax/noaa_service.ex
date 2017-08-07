defmodule Noaax.NoaaService do
  @moduledoc """
  Fetch NOAA web page
  """

  @noaa_url Application.get_env(:noaax, :noaa_url)
  @noaa_stations_url Application.get_env(:noaax, :state_station_url)

  @doc """
  Fetch station data, will return a tuple in the form of
  `{ :ok, body }` or `{ :error, body }`
  """
  def fetch(station) do
    data_station_url(station)
    |> HTTPoison.get
    |> handle_response
  end

  @doc """
  Fetch station data, will return a tuple in the form of
  `{ :ok, body }` or `{ :error, body }`
  """
  def fetch_list_station(statename) do
    stations_url(statename)
    |> HTTPoison.get
    |> handle_response
  end
  
  @doc """
  http://w1.weather.gov/xml/current_obs/STATION.xml
  """
  def data_station_url(station) do
    "#{@noaa_url}/#{station}.xml"
  end
  
  @doc """
  http://w2.weather.gov/xml/current_obs/seek.php?state=STATENAME&Find=Find
  """
  def stations_url(statename) do
    "#{@noaa_stations_url}#{String.downcase(statename)}&Find=Find"
  end

  @doc """
  Return {:ok, body} if http status code is 200

  Return {:error, body} if http status code is not 200
  """
  def handle_response({ :ok, %{status_code: 200, body: body} }) do
    { :ok, body }
  end
  
  def handle_response({ _, %{status_code: _, body: body} }) do
    { :error, body }
  end
end
