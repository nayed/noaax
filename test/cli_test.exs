defmodule CliTest do
  use ExUnit.Case
  doctest Noaax

  import Noaax.CLI, only: [ parse_args: 1 ]

  test ":version returned by parsing -v and --version option" do
    assert parse_args(["-v", "anything"]) == :version
    assert parse_args(["--version", "anything"]) == :version
  end

  test ":help returned by parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test ":state returned with state_name if given" do
    assert parse_args(["--state", "CA"]) == { :state, "CA" }
  end

  test "returns station if station given" do
    assert parse_args(["KDTO"]) == "KDTO"
  end
end
