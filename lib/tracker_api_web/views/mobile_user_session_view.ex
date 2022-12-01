defmodule TrackerWeb.MobileUserSessionView do
  use TrackerWeb, :view

  def render("invalid_form.json", %{changeset: changeset}) do
    changeset = Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    %{error: true, status: "Invalid form values", errors: changeset}
  end

  def render("registraion.json", %{user: user}) do
    %{error: false, status: :created, user: user}
  end
end
