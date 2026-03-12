defmodule BackendWeb.Auth.SetAccount do
  import Plug.Conn
  alias BackendWeb.Auth.ErrorResponse
  alias Backend.Accounts

  def init(opts), do: opts

  def call(conn, _opts) do
    account =
      cond do
        conn.assigns[:account] ->
          conn.assigns[:account]

        account = Guardian.Plug.current_resource(conn) ->
          account

        account_id = get_session(conn, :id) ->
          Accounts.get_utilisateur!(account_id)

        true ->
          raise(ErrorResponse.Unauthorized)
      end

    conn = assign(conn, :account, account)

    # Vérifier si la route contient un paramètre "id"
    # et comparer avec l'ID du compte courant
    case conn.params["id"] do
      nil ->
        # pas de vérification nécessaire
        conn

      resource_id ->
        if to_string(account.id) != to_string(resource_id) do
          raise(ErrorResponse.Unauthorized)
        else
          conn
        end
    end
  end
end
