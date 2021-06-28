defmodule ExtransferapiWeb.AuthView do
  use ExtransferapiWeb, :view
  alias ExtransferapiWeb.AuthView

  def render("login.json", %{:account => account, :token => token}) do
    %{
      data: %{
        account: render_one(account, AuthView, "privileged_user.json", as: :account)
      },
      token: token
    }
  end

  def render("register.json", %{:account => account}) do
    %{
      data: render_one(account, AuthView, "privileged_user.json", as: :account)
    }
  end

  def render("privileged_user.json", %{account: account}) do
    %{
      id: account.id,
      balance: account.balance/100,
      firstname: account.firstname,
      cpf: account.cpf,
      lastname: account.lastname,
    }
  end
end
