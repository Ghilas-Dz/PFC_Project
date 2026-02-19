defmodule BackendWeb.Auth.Errorhandler do
  @behaviour Guardian.Plug.ErrorHandler

  import Plug.Conn

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {type, reason}, _opts) do
    reason_str =
      case reason do
        r when is_binary(r) ->
          r

        %_{} = struct ->
          try do
            Exception.message(struct)
          rescue
            _ -> inspect(struct)
          end

        other ->
          inspect(other)
      end

    body = Jason.encode!(%{error: to_string(type), message: reason_str})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end
end
