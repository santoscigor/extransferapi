defmodule ExtransferapiWeb.AccountView do
  use ExtransferapiWeb, :view
  alias ExtransferapiWeb.AccountView

  def render("get_balance.json", %{:account => account}) do
    %{
      data: render_one(account, AccountView, "account_balance.json", as: :account)
    }
  end

  def render("account_balance.json", %{account: account}) do
    %{
      balance: account.balance/100,
    }
  end
end
