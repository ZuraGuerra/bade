defmodule Bade.Templates.Services.Buy do
  @doc """
  Generates a 'payment_summary' map, needed to create a buy button template.
  'payment_type' must be either "FIXED_AMOUNT" or "FLEXIBLE AMOUNT".
  'requested_user_info' must be a list which can contain the strings "shipping address", "contact_name",
  "contact_phone" and/or "contact_email", depending on your needs.
  'price_list' must be a list of maps; you can use 'price_list/2' (inside this module) to generate each one.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/buy-button
  """
  def payment_summary(currency, payment_type, merchant_name, requested_user_info, price_list, is_test_payment \\ true) do
    %{
      "currency" => currency,
      "payment_type" => payment_type,
      "merchant_name" => merchant_name,
      "requested_user_info" => requested_user_info,
      "price_list" => price_list,
      "is_test_payment" => is_test_payment
    }
  end

  @doc """
  Generates a 'price_list' map, needed to create a list for a 'payment_summary' map.
  Check the FB docs: https://developers.facebook.com/docs/messenger-platform/send-api-reference/buy-button
  """
  def price_list(label, amount), do: %{"label" => label, "amount" => amount}
end
