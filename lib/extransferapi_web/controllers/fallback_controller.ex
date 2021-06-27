defmodule ExtransferapiWeb.FallbackController do
  use ExtransferapiWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ExtransferapiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ExtransferapiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ExtransferapiWeb.ErrorView)
    |> render(:"401")
  end

  def call(conn, {:error, :bad_request, err}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ExtransferapiWeb.ErrorView)
    |> render(:"400", error: err)
  end
end
