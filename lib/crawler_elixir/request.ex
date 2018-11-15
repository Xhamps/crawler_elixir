defmodule CrawlerElixir.Request do
  alias CrawlerElixir.Page

  def get_links url do
    IO.puts "Crawling page - #{url}"

    url
    |> HTTPoison.get
    |> parse_html()
    |> Page.parse_links()
    |> (fn links -> %Page{
                    url: url,
                    assets: Enum.filter(links, &Page.assets?/1) |> MapSet.new,
                    external_links: Enum.filter(links, &Page.external_link?/1) |> MapSet.new,
                    internal_links: Enum.filter(links, &Page.internal_link?/1) |> MapSet.new
                } end).()
  end

  def parse_html({:ok, %HTTPoison.Response{status_code: 200, body: body}}), do: body
  def parse_html({:ok, %HTTPoison.Response{status_code: 404, request_url: url}}) do
    IO.puts "Not found ;( - #{url}"
    ""
  end

  def parse_html({:error, %HTTPoison.Error{reason: reason}}) do
    IO.inspect reason
    ""
  end
end
