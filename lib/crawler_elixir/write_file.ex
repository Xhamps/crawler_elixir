defmodule CrawlerElixir.Write do
  def encode({:ok, data}), do: prettify(data)
  def encode(data) do
    IO.puts "Encode file"
    data
    |> JSX.encode
    |> encode
  end

  def prettify({:ok, data}), do: save_data(data)
  def prettify(data) do
    IO.puts "Prettify file"
    data
    |> JSX.prettify
    |> prettify
  end

  def save_data(data), do: File.write("./links.json", data , [:binary])
end
