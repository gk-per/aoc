defmodule AdventOfCode.Day6 do
  @moduledoc """
  Documentation for `AdventOfCode.Day6`.
  """

  @doc """


  ## Examples


  """
  def part_one() do
    graphemes =
      read_in()
      |> String.graphemes()
      |> do_check_for_each_letter(4)
  end

  def part_two() do
    graphemes =
      read_in()
      |> String.graphemes()
      |> do_check_for_each_letter2(14)
  end

  def do_check_for_each_letter(graphemes, chars_checked) do
    [first, second, third, fourth | tail] = graphemes

    cond do
      first == second or
        first == third or
        first == fourth or
        second == third or
        second == fourth or
          third == fourth ->
        graphemes = Enum.drop(graphemes, 1)
        do_check_for_each_letter(graphemes, chars_checked + 1)

      true ->
        IO.inspect("found,#{first}#{second}#{third}#{fourth}@#{chars_checked}")
    end
  end

  def do_check_for_each_letter2(graphemes, chars_checked) do
    [a,b,c,d,e,f,g,h,i,j,k,l,m,n | tail] = graphemes

    unique_count = [a,b,c,d,e,f,g,h,i,j,k,l,m,n]
    |> Enum.uniq()
    |> Enum.count()
    cond do
      unique_count == 14 ->
        IO.inspect("found,#{a}#{b}#{c}#{d}#{e}...#{m}#{n}#@#{chars_checked}")

      true ->
        graphemes = Enum.drop(graphemes, 1)
        do_check_for_each_letter2(graphemes, chars_checked + 1)
    end
  end

  defp read_in() do
    "lib/input.txt"
    |> File.read!()
  end
end
