defmodule Tracker.Token do
  @secret_key "user auth"
  # token for 2 weeks
  @max_age 14 * 86_400

  @doc """
  Create token with user id and sign with secret key
  """
  def sign(id) when is_integer(id) do
    Phoenix.Token.sign(TrackerWeb.Endpoint, @secret_key, id)
  end

  @doc """
  Verify given token by secret key and max age
  (if it has been more than max_age since token was genereated, it cannot be verified)
  """
  def verify(token) do
    case Phoenix.Token.verify(TrackerWeb.Endpoint, @secret_key, token, max_age: @max_age) do
      {:ok, id} -> {:ok, id}
      _error -> {:error, :unauthenticated}
    end
  end
end
