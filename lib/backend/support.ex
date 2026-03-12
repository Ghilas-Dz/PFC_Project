defmodule Backend.Support do
  @moduledoc """
  The Support context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Support.Ticket

  @doc """
  Returns the list of tickets.

  ## Examples

      iex> list_tickets()
      [%Ticket{}, ...]

  """
  def list_tickets do
    Repo.all(Ticket)
  end

  @doc """
  Gets a single ticket.

  Raises `Ecto.NoResultsError` if the Ticket does not exist.

  ## Examples

      iex> get_ticket!(123)
      %Ticket{}

      iex> get_ticket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ticket!(id), do: Repo.get!(Ticket, id)

  @doc """
  Creates a ticket.

  ## Examples

      iex> create_ticket(%{field: value})
      {:ok, %Ticket{}}

      iex> create_ticket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ticket(attrs \\ %{}) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ticket.

  ## Examples

      iex> update_ticket(ticket, %{field: new_value})
      {:ok, %Ticket{}}

      iex> update_ticket(ticket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ticket.

  ## Examples

      iex> delete_ticket(ticket)
      {:ok, %Ticket{}}

      iex> delete_ticket(ticket)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ticket changes.

  ## Examples

      iex> change_ticket(ticket)
      %Ecto.Changeset{data: %Ticket{}}

  """
  def change_ticket(%Ticket{} = ticket, attrs \\ %{}) do
    Ticket.changeset(ticket, attrs)
  end

  alias Backend.Support.Commentaire

  @doc """
  Returns the list of commentaires.

  ## Examples

      iex> list_commentaires()
      [%Commentaire{}, ...]

  """
  def list_commentaires do
    Repo.all(Commentaire)
  end

  @doc """
  Gets a single commentaire.

  Raises `Ecto.NoResultsError` if the Commentaire does not exist.

  ## Examples

      iex> get_commentaire!(123)
      %Commentaire{}

      iex> get_commentaire!(456)
      ** (Ecto.NoResultsError)

  """
  def get_commentaire!(id), do: Repo.get!(Commentaire, id)

  @doc """
  Creates a commentaire.

  ## Examples

      iex> create_commentaire(%{field: value})
      {:ok, %Commentaire{}}

      iex> create_commentaire(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_commentaire(attrs \\ %{}) do
    %Commentaire{}
    |> Commentaire.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a commentaire.

  ## Examples

      iex> update_commentaire(commentaire, %{field: new_value})
      {:ok, %Commentaire{}}

      iex> update_commentaire(commentaire, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_commentaire(%Commentaire{} = commentaire, attrs) do
    commentaire
    |> Commentaire.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a commentaire.

  ## Examples

      iex> delete_commentaire(commentaire)
      {:ok, %Commentaire{}}

      iex> delete_commentaire(commentaire)
      {:error, %Ecto.Changeset{}}

  """
  def delete_commentaire(%Commentaire{} = commentaire) do
    Repo.delete(commentaire)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking commentaire changes.

  ## Examples

      iex> change_commentaire(commentaire)
      %Ecto.Changeset{data: %Commentaire{}}

  """
  def change_commentaire(%Commentaire{} = commentaire, attrs \\ %{}) do
    Commentaire.changeset(commentaire, attrs)
  end

  alias Backend.Support.Notification

  @doc """
  Returns the list of notifications.

  ## Examples

      iex> list_notifications()
      [%Notification{}, ...]

  """
  def list_notifications do
    Repo.all(Notification)
  end

  @doc """
  Gets a single notification.

  Raises `Ecto.NoResultsError` if the Notification does not exist.

  ## Examples

      iex> get_notification!(123)
      %Notification{}

      iex> get_notification!(456)
      ** (Ecto.NoResultsError)

  """
  def get_notification!(id), do: Repo.get!(Notification, id)

  @doc """
  Creates a notification.

  ## Examples

      iex> create_notification(%{field: value})
      {:ok, %Notification{}}

      iex> create_notification(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_notification(attrs \\ %{}) do
    %Notification{}
    |> Notification.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a notification.

  ## Examples

      iex> update_notification(notification, %{field: new_value})
      {:ok, %Notification{}}

      iex> update_notification(notification, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_notification(%Notification{} = notification, attrs) do
    notification
    |> Notification.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a notification.

  ## Examples

      iex> delete_notification(notification)
      {:ok, %Notification{}}

      iex> delete_notification(notification)
      {:error, %Ecto.Changeset{}}

  """
  def delete_notification(%Notification{} = notification) do
    Repo.delete(notification)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking notification changes.

  ## Examples

      iex> change_notification(notification)
      %Ecto.Changeset{data: %Notification{}}

  """
  def change_notification(%Notification{} = notification, attrs \\ %{}) do
    Notification.changeset(notification, attrs)
  end
end
