defmodule Extransferapi.Auth.AccountToken do
  use Ecto.Schema
  import Ecto.Query

  @primary_key {:id, :binary_id, autogenerate: true}

  @rand_size 32

  @session_validity_in_days 60

  schema "accounts_tokens" do
    field :token, :binary
    field :context, :string
    field :sent_to, :string
    belongs_to :account, Extransferapi.Auth.Account, foreign_key: :account_id, type: :binary_id

    timestamps(updated_at: false)
  end

  def build_session_token(account) do
    token = Base.url_encode64(:crypto.strong_rand_bytes(@rand_size), padding: false)
    {token, %Extransferapi.Auth.AccountToken{token: token, context: "session", account_id: account.id}}
  end

  def verify_session_token_query(token) do
    query =
      from token in token_and_context_query(token, "session"),
        join: account in assoc(token, :account),
        where: token.inserted_at > ago(@session_validity_in_days, "day"),
        select: account

    {:ok, query}
  end

  def token_and_context_query(token, context) do
    from Extransferapi.Auth.AccountToken, where: [token: ^token, context: ^context]
  end
end
