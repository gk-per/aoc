defmodule AdventOfCode.Day1 do
  @moduledoc """
  Documentation for `AdventOfCode.Day1`.
  """

  @doc """
  Day 1 of Advent of Code. Counting elf cookie calories.

  ## Examples

      iex> AdventOfCode.Day1.part_one()
      66487

  """
  def part_one do
    collate_cookie_calorie_counts()
    |> Enum.max()
  end

  def part_two do
    collate_cookie_calorie_counts()
    |> Enum.sort(&(&1 > &2))
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp collate_cookie_calorie_counts() do
    "lib/input.txt"
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(fn x -> String.split(x, "\n") end)
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end)
    |> Enum.map(fn x -> Enum.sum(x) end)
  end
end
