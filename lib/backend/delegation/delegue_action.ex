defmodule Backend.Delegation.DelegueAction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "delegue_actions" do
    field :action, :string
    field :details, :string
    belongs_to :delegue, Backend.Accounts.Etudiant, foreign_key: :delegue_id
    belongs_to :ticket, Backend.Support.Ticket, foreign_key: :ticket_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(delegue_action, attrs) do
    delegue_action
    |> cast(attrs, [:action, :details, :delegue_id, :ticket_id])
    |> validate_required([:action, :details, :delegue_id])
    |> foreign_key_constraint(:delegue_id)
    |> foreign_key_constraint(:ticket_id)
  end
end
