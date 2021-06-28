defmodule ExtransferapiWeb.TransferView do
  use ExtransferapiWeb, :view
  alias ExtransferapiWeb.TransferView

  def render("register.json", %{:transfer => transfer}) do
    %{
      data: render_one(transfer, TransferView, "transaction_complete.json", as: :transfer),
    }
  end

  def render("transaction_complete.json", %{transfer: transfer}) do
    %{
      id: transfer.id,
      reversal_transfer_id: transfer.reversal_transfer_id,
      value: (transfer.value)/100,
      receiver_id: transfer.receiver_id,
      sender_id: transfer.sender_id
    }
  end
end
