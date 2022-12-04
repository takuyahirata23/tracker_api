defmodule TrackerWeb.MobileUserSessionView do
  use TrackerWeb, :view

  def render("invalid_form.json", %{changeset: changeset}) do
    changeset = Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    %{error: true, status: "Invalid form values", errors: changeset}
  end

  def render("registraion.json", %{user: user, token: token}) do
    %{error: false, status: "User created", user: user, token: token}
  end

  def render("login.json", %{user: user, token: token}) do
    %{error: false, status: "User found", user: user, token: token}
  end

  def render("not_found.json", _) do
    %{error: true, status: "User not found"}
  end
end
