defmodule BackendWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", plug_status: 401
end

defmodule BackendWeb.Auth.ErrorResponse.Forbidden do
  defexception message: "Forbidden", plug_status: 403
end

defmodule BackendWeb.Auth.ErrorResponse.Notfound do
  defexception message: "Not Found", plug_status: 404
end
