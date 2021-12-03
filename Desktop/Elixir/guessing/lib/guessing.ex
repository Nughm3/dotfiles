defmodule Guessing do
  def main() do
    secret = 1..100 |> Enum.random()
    guesses = loop(secret)
    IO.puts("You won in #{guesses} guesses!")
  end

  defp loop(secret, acc \\ 1) do
    guess = IO.gets("Guess a number: ") |> String.trim() |> String.to_integer()

    cond do
      guess == secret ->
        acc

      guess < secret ->
        IO.puts("Too low")
        loop(secret, acc + 1)

      guess > secret ->
        IO.puts("Too high")
        loop(secret, acc + 1)
    end
  end
end
