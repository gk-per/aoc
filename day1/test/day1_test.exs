defmodule AdventOfCode.Day1Test do
  use ExUnit.Case
  doctest AdventOfCode.Day1

 # so lazy
  test "part one" do
    assert AdventOfCode.Day1.part_one() == 66487
  end

  test "part two" do
    assert AdventOfCode.Day1.part_two() == 197301
  end
end
