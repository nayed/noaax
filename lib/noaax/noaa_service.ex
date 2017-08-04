defmodule Noaax.NoaaService do
  @docmodule """
  """

  @doc """
  Fetch station data, will return a tuple in the form of
  `{ :ok, body }` or `{ :error, body }`
  """
  def fetch(station) do
    noaa_url(station)
    |> HTTPoison.get
    |> handle_response
  end

  def noaa_url(station) do
    "http://w1.weather.gov/xml/current_obs/#{station}.xml"
  end

  def handle_response({ :ok, %{status_code: 200, body: body} }) do
    { :ok, body }
  end

  def handle_response({ _, %{status_code: _, body: body} }) do
    { :error, body }
  end
end
