defmodule CrawlerElixir.Crawler do
  alias CrawlerElixir.{Page, Request}

  def run urls, crawled \\ MapSet.new() do
    pages = urls
    |> Enum.filter(&filter_url(&1, crawled))
    |> find_links_multiple_pages()

    crawled = crawled
    |> update_crawled(urls)

    pages
    |> Enum.map(fn page ->
      run(page.internal_links , crawled)
      |> (fn childrens -> %{page | childrens: page.childrens ++ childrens} end).()
    end)
  end

  def update_crawled crawled, pages do
    pages
    |> Enum.reduce(crawled, fn (url, acc) ->
      url
      |> normalize_url()
      |> MapSet.union(acc)
    end)
  end

  def find_links_multiple_pages urls do
    urls
    #|> Enum.map(&Request.get_links/1)
    |> Enum.map(&(Task.async(fn -> Request.get_links(&1) end)))
    |> Enum.map(&(Task.await(&1)))
  end

  def filter_url url, crawled do
    url
    |> remove_fragments()
    |> (fn url-> !MapSet.member?(crawled, url) && Page.internal_link?(url) end).()
  end
  

  def normalize_url url do
    url
    |> remove_fragments()
    |> (fn url -> [url] end).()
    |> MapSet.new()
  end

  def remove_fragments url do
    url
    |> String.split("#")
    |> List.first()
  end
end

