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
    |> Enum.map(fn x -> abc_to_number(x) end)
    |> Enum.sum()
  end

  def part_two() do
    read_in()
    |> Enum.chunk_every(3)
    |> Enum.map(fn x -> determine_common_letter(x) end)
    |> Enum.map(fn x -> abc_to_number(List.first(x)) end)
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

  defp abc_to_number(x) do
    case x do
      "a" -> 1
      "b" -> 2
      "c" -> 3
      "d" -> 4
      "e" -> 5
      "f" -> 6
      "g" -> 7
      "h" -> 8
      "i" -> 9
      "j" -> 10
      "k" -> 11
      "l" -> 12
      "m" -> 13
      "n" -> 14
      "o" -> 15
      "p" -> 16
      "q" -> 17
      "r" -> 18
      "s" -> 19
      "t" -> 20
      "u" -> 21
      "v" -> 22
      "w" -> 23
      "x" -> 24
      "y" -> 25
      "z" -> 26
      "A" -> 27
      "B" -> 28
      "C" -> 29
      "D" -> 30
      "E" -> 31
      "F" -> 32
      "G" -> 33
      "H" -> 34
      "I" -> 35
      "J" -> 36
      "K" -> 37
      "L" -> 38
      "M" -> 39
      "N" -> 40
      "O" -> 41
      "P" -> 42
      "Q" -> 43
      "R" -> 44
      "S" -> 45
      "T" -> 46
      "U" -> 47
      "V" -> 48
      "W" -> 49
      "X" -> 50
      "Y" -> 51
      "Z" -> 52
    end
  end
end
