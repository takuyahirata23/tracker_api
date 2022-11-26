defmodule Tracker.Token do
  # token for 2 weeks
  @max_age 14 * 86_400

  @doc """
  Create token with user id and sign with secret key
  """
  def sign(id) when is_integer(id) do
    case Application.fetch_env!(:tracker_api, :my_token) do
      {:ok, key} -> Phoenix.Token.sign(TrackerWeb.Endpoint, key, id)
      _ -> {:error, "key not found"}
    end
  end

  @doc """
  Verify given token by secret key and max age
  (if it has been more than max_age since token was genereated, it cannot be verified)
  """
  def verify(token) do
    case Application.fetch_env!(:tracker_api, :my_token) do
      {:ok, key} ->
        case Phoenix.Token.verify(TrackerWeb.Endpoint, key, token, max_age: @max_age) do
          {:ok, id} -> {:ok, id}
          _error -> {:error, :unauthenticated}
        end

      _ ->
        {:error, "key not found"}
    end
  end
end
