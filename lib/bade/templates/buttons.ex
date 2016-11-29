defmodule Bade.Templates.Buttons do
  @doc """
  Generates an url button template as a map and encodes it to json.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/url-button
  """
  def url!(title, url, webview_height_ratio \\ "full", messenger_extensions \\ false, fallback_url \\ :empty) do
    fallback_url = assign_fallback_url(url, fallback_url)
    url(title, url, webview_height_ratio, messenger_extensions, fallback_url) |> Poison.encode!
  end

  @doc """
  Generates an url button template as a map. Use it with a bang ('url!/5') to receive a json.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/url-button
  """
  def url(title, url, webview_height_ratio \\ "full", messenger_extensions \\ false, fallback_url \\ :empty) do
    fallback_url = assign_fallback_url(url, fallback_url)
    %{
      "type" => "web_url",
      "url" => url,
      "title" => title,
      "webview_height_ratio" => webview_height_ratio,
      "messenger_extensions" => messenger_extensions,
      "fallback_url" => fallback_url
    }
  end

  @doc """
  Generates a postback button template and encodes it to json.
  'title' has a character limit of 20.
  'payload' has a character limit of 1000.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/postback-button
  """
  def postback!(title, payload), do: postback(title, payload) |> Poison.encode!

  @doc """
  Generates a postback button template. Use it with a bang ('postback!/2') to receive a json.
  'title' has a character limit of 20.
  'payload' has a character limit of 1000.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/postback-button
  """
  def postback(title, payload) do
    %{
      "type" => "postback",
      "title" => title,
      "payload" => payload
    }
  end

  ######## PRIVATE FUNCTIONS ########

  defp assign_fallback_url(url, :empty), do: url
  defp assign_fallback_url(url, fallback_url), do: fallback_url
end
