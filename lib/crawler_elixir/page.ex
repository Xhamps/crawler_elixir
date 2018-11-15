defmodule CrawlerElixir.Page do
  @base_url "https://elixir-lang.org"
  @filter_assets ~r/(css|js|jpg|png|gif|ico|xml|cvs)/
  @filter_base_path Regex.compile!("^(\/|#{@base_url})")
  @path_google_fonts "fonts.googleapis.com"

  defstruct url: '', assets: MapSet.new(), external_links: MapSet.new(), internal_links: MapSet.new(), childrens: []

  def parse_links body do
    ~r/(href|src)=[\'"]([^\'" >]+)/
    |> Regex.scan(body)
    |> Enum.map(&normalize_url/1)
  end

  def normalize_url [_, _, url] do
    if String.starts_with?( url, "/") && !String.contains?(url, @path_google_fonts) do
      @base_url <> url
    else
      url
    end
  end

  def assets?(url), do: String.match?(url, @filter_assets)

  def external_link?(url), do: !String.match?(url, @filter_base_path)

  def internal_link?(url), do: String.match?(url, @filter_base_path) && !assets?(url)
end
