defmodule Tracker.Token do
  # token for 2 weeks
  @max_age 14 * 86_400

  @doc """
  Create token with user id and sign with secret key
  """
  def sign(id) when is_binary(id) do
    key = Application.fetch_env!(:tracker_api, :token_secret_key)
    Phoenix.Token.sign(TrackerWeb.Endpoint, key, id)
  end

  @doc """
  Verify given token by secret key and max age
  (if it has been more than max_age since token was genereated, it cannot be verified)
  """
  def verify(token) do
    key = Application.fetch_env!(:tracker_api, :token_secret_key)

    case Phoenix.Token.verify(TrackerWeb.Endpoint, key, token, max_age: @max_age) do
      {:ok, id} -> {:ok, id}
      _error -> {:error, :unauthenticated}
    end
  end
end
