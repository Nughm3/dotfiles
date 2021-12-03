defmodule GuessingTest do
  use ExUnit.Case
  doctest Guessing

  test "greets the world" do
    assert Guessing.hello() == :world
  end
end
