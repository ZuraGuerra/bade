defmodule Bade.Templates.Buttons do
  def url(title, url, webview_height_ratio \\ "full", messenger_extensions \\ false, fallback_url \\ url) do
    %{
      "type" => "web_url",
      "url" => url,
      "title" => title,
      "webview_height_ratio" => webview_height_ratio,
      "messenger_extensions" => messenger_extensions,
      "fallback_url" => fallback_url
    }
  end
end
