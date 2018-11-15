defmodule CrawlerElixir do
  @moduledoc """
  This code will thr crawler to get all link on Elixir-lang.org.
  """

  alias CrawlerElixir.{Crawler, Write}

  def main(_args) do
    HTTPoison.start

    [ "https://elixir-lang.org" ]
    |> Crawler.run()
    |> Write.encode
  end
end
