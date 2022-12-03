defmodule AdventOfCode.Day3 do
  @moduledoc """
  Documentation for `AdventOfCode.Day3`.
  """

  @doc """


  ## Examples


  """
  def part_one() do
    first_halves =
      read_in()
      |> Enum.map(fn x -> String.slice(x, 0..(trunc(String.length(x) / 2) - 1)) end)
      |> Enum.map(fn x -> String.codepoints(x) end)

    second_halves =
      read_in()
      |> Enum.map(fn x ->
        String.slice(x, trunc(String.length(x) / 2)..trunc(String.length(x)))
      end)
      |> Enum.map(fn x -> String.codepoints(x) end)

    Enum.zip_with(first_halves, second_halves, fn x, y -> enum_compare_zip(x, y) end)
    |> Enum.concat()
    |> Enum.map(fn x -> score(x) end)
    |> Enum.sum()
  end

  def part_two() do
    read_in()
    |> Enum.chunk_every(3)
    |> Enum.map(fn x -> determine_common_letter(x) end)
    |> Enum.map(fn x -> score(List.first(x)) end)
    |> Enum.sum()
  end

  defp read_in() do
    "lib/input.txt"
    |> File.read!()
    |> String.split("\n")
  end

  defp enum_compare_zip(first_half, second_half) do
    Enum.map(first_half, fn x ->
      cond do
        Enum.member?(second_half, x) ->
          x

        true ->
          nil
      end
    end)
    |> Enum.filter(& &1)
    |> Enum.uniq()
  end

  defp determine_common_letter(x) do
    [one, two, three] = x
    one = String.codepoints(one)
    two = String.codepoints(two)
    three = String.codepoints(three)

    Enum.map(one, fn x ->
      cond do
        Enum.member?(two, x) and Enum.member?(three, x) -> x
        true -> nil
      end
    end)
    |> Enum.filter(& &1)
    |> Enum.uniq()
  end

  defp score(<<lower::utf8>>) when lower in ?a..?z, do: lower - ?a + 1
  defp score(<<upper::utf8>>) when upper in ?A..?Z, do: upper - ?A + 27
end
