defmodule Extransferapi.Auth.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @fields [:firstname, :lastname, :cpf, :password, :balance]

  @derive {Inspect, except: [:password]}
  schema "accounts" do
    field :firstname, :string
    field :lastname, :string
    field :cpf, :string,  precision: 11, scale: 0
    field :hashed_password, :string
    field :balance, :integer
    field :password, :string, virtual: true
    timestamps()
  end

  def registration_changeset(user, params, opts \\ []) do
    user
    |> cast(params, @fields)
    |> validate_required([:firstname, :lastname, :cpf, :password, :balance])
    |> validate_cpf()
    |> validate_password(opts)
  end

  defp validate_cpf(changeset) do
    changeset
    |> validate_format(:cpf, ~r/^[0-9]{11}$/,  message: "must be a valid cpf")
    |> validate_length(:cpf, max: 11)
    |> unsafe_validate_unique(:cpf, Extransferapi.Repo)
    |> unique_constraint(:cpf)
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 80)
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end

  def valid_password?(%Extransferapi.Auth.Account{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  # prevents from timing attacks
  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

 def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end
end
