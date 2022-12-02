defmodule Day2Test do
  use ExUnit.Case
  doctest AdventOfCode.Day2

  test "both parts" do
     assert AdventOfCode.Day2.part_one() == 11767
     assert AdventOfCode.Day2.part_two() == 13886
  end
end
