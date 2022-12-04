defmodule AdventOfCode.Day4 do
  @moduledoc """
  Documentation for `AdventOfCode.Day4`.
  """

  @doc """


  ## Examples


  """
  def part_one() do
    read_in_and_split()
    |> Enum.map(fn x ->
      [[a, b], [c, d]] = x
      [range1, range2] = [sti(a)..sti(b), sti(c)..sti(d)]

      MapSet.subset?(MapSet.new(range1), MapSet.new(range2)) or
        MapSet.subset?(MapSet.new(range2), MapSet.new(range1))
    end)
    |> Enum.filter(fn x ->
      x === true
    end)
    |> Enum.count()
  end

  def part_two() do
    read_in_and_split()
    |> Enum.map(fn x ->
      [[a, b], [c, d]] = x
      [range1, range2] = [sti(a)..sti(b), sti(c)..sti(d)]
      Range.disjoint?(range1, range2)
    end)
    |> Enum.filter(fn x ->
      x === false
    end)
    |> Enum.count()
  end

  defp sti(x) do
    String.to_integer(x)
  end

  defp read_in_and_split() do
    "lib/input.txt"
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn x -> String.split(x, ",") end)
    |> Enum.map(fn x ->
      Enum.map(x, fn y -> String.split(y, "-") end)
    end)
  end
end
