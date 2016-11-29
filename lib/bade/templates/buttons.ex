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
  def postback(title, payload), do: generic("postback", title, payload)

  @doc """
  Generates a call button template and encodes it to json.
  'title' has a character limit of 20.
  'payload' has a character limit of 1000 and must have "+" prefix
  followed by the country code, area code and local number.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/call-button
  """
  def call!(title, payload), do: generic("phone_number", title, payload) |> Poison.encode!

  @doc """
  Generates a call button template. Use it with a bang ('call!/2') to receive a json.
  'title' has a character limit of 20.
  'payload' has a character limit of 1000 and must have "+" prefix
  followed by the country code, area code and local number.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/call-button
  """
  def call(title, payload), do: generic("phone_number", title, payload)

  @doc """
  Generates a share button template and encodes it to json.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/share-button
  """
  def share!, do: generic("element_share") |> Poison.encode!

  @doc """
  Generates a share button template. Use it with a bang ('share!/0') to receive a json.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/share-button
  """
  def share, do: generic("element_share")

  @doc """
  Generates a buy button template and encodes it to json.
  You can generate the required fields 'payment_summary' and 'price_list' using
  'Bade.Templates.Services.Buy.payment_summary/6' and 'Bade.Templates.Services.Buy.price_list/2';
  read their docs for more details.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/buy-button
  """
  def buy!(payload, payment_summary), do: buy(payload, payment_summary) |> Poison.encode!

  @doc """
  Generates a buy button template. Use it with a bang ('buy!/2') to receive a json.
  You can generate the required fields 'payment_summary' and 'price_list' using
  'Bade.Templates.Services.Buy.payment_summary/6' and 'Bade.Templates.Services.Buy.price_list/2';
  read their docs for more details.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/buy-button
  """
  def buy(payload, payment_summary) do
    %{
      "type" => "payment",
      "title" => "buy",
      "payload" => payload,
      "payment_summary" => payment_summary
    }
  end

  @doc """
  Generates a log in button template and encodes it to json.
  'url' must be using https.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/account-linking/link-account
  """
  def log_in!(url), do: log_in(url) |> Poison.encode!

  @doc """
  Generates a log in button template. Use it with a bang ('log_in!/1') to receive a json.
  'url' must be using https.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/account-linking/link-account
  """
  def log_in(url), do: %{"type" => "account_link", "url" => url}

  ######## PRIVATE FUNCTIONS ########

  defp assign_fallback_url(url, :empty), do: url
  defp assign_fallback_url(url, fallback_url), do: fallback_url

  defp generic(type), do: %{"type" => type}
  defp generic(type, title, payload) do
    %{
      "type" => type,
      "title" => title,
      "payload" => payload
    }
  end
end
