defmodule OutputTest do
  use ExUnit.Case
  import Noaax.Output

  doctest Noaax

  @data [
    {:pi, "xml", [{"version", "1.0"}, {"encoding", "ISO-8859-1"}]},
    {:pi, "xml-stylesheet", [{"href", "latest_ob.xsl"}, {"type", "text/xsl"}]},
    {"current_observation",
      [
        {"version", "1.0"}, {"xmlns:xsd", "http://www.w3.org/2001/XMLSchema"},
        {"xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance"},
        {"xsi:nonamespaceschemalocation",
        "http://www.weather.gov/view/current_observation.xsd"}
      ],
      [
        {"credit", [], ["NOAA's National Weather Service"]},
        {"credit_url", [], ["http://weather.gov/"]},
        {"image", [],
          [
            {"url", [], ["http://weather.gov/images/xml_logo.gif"]},
            {"title", [], ["NOAA's National Weather Service"]},
            {"link", [], ["http://weather.gov"]}
          ]
        },
        {"suggested_pickup", [], ["15 minutes after the hour"]},
        {"suggested_pickup_period", [], ["60"]},
        {"location", [], ["Denton Enterprise Airport, TX"]},
        {"station_id", [], ["KDTO"]},
        {"latitude", [], ["33.20505"]},
        {"longitude", [], ["-97.20061"]},
        {"observation_time", [], ["Last Updated on Aug 8 2017, 4:53 am CDT"]},
        {"observation_time_rfc822", [], ["Tue, 08 Aug 2017 04:53:00 -0500"]},
        {"weather", [], ["A Few Clouds"]},
        {"temperature_string", [], ["73.0 F (22.8 C)"]},
        {"temp_f", [], ["73.0"]},
        {"temp_c", [], ["22.8"]},
        {"relative_humidity", [], ["94"]},
        {"wind_string", [], ["Northeast at 8.1 MPH (7 KT)"]},
        {"wind_dir", [], ["Northeast"]},
        {"wind_degrees", [], ["30"]},
        {"wind_mph", [], ["8.1"]},
        {"wind_kt", [], ["7"]},
        {"pressure_string", [], ["1015.5 mb"]},
        {"pressure_mb", [], ["1015.5"]},
        {"pressure_in", [], ["30.02"]},
        {"dewpoint_string", [], ["71.1 F (21.7 C)"]},
        {"dewpoint_f", [], ["71.1"]},
        {"dewpoint_c", [], ["21.7"]},
        {"visibility_mi", [], ["10.00"]},
        {"icon_url_base", [], ["http://forecast.weather.gov/images/wtf/small/"]},
        {"two_day_history_url", [], ["http://www.weather.gov/data/obhistory/KDTO.html"]},
        {"icon_url_name", [], ["nfew.png"]},
        {"ob_url", [], ["http://www.weather.gov/data/METAR/KDTO.1.txt"]},
        {"disclaimer_url", [], ["http://weather.gov/disclaimer.html"]},
        {"copyright_url", [], ["http://weather.gov/disclaimer.html"]},
        {"privacy_policy_url", [], ["http://weather.gov/notice.html"]}
      ]
    }
  ]

  test "Returns data from a list of tuples key-value" do
    result_predict = [
      {"Weather", ["A Few Clouds"]},
      {"Temperature", ["73.0 F (22.8 C)"]},
      {"Dewpoint", ["71.1 F (21.7 C)"]},
      {"Relative Humidity", ["94"]},
      {"Heat Index", "No data available"},
      {"Wind", ["Northeast at 8.1 MPH (7 KT)"]},
      {"Visibility", ["10.00"]},
      {"MSL Pressure", ["1015.5 mb"]},
      {"Altimeter", ["30.02"]}
    ]
    
    result = Enum.map kv(), fn({k, v}) ->
      {v, retrieve(@data, k)}
    end

    assert result_predict == result
  end

  test "Returns `No data available` if key given to `retrieve` function doesn't exist in @data" do
    assert "No data available" == retrieve(@data, "nayed")
  end
end
