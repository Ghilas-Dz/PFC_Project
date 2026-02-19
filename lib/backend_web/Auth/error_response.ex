defmodule BackendWeb.Auth.ErrorResponse.Unauthorized do
  defexception message: "Unauthorized", put_status: 401
end

defmodule BackendWeb.Auth.ErrorResponse.Forbidden do
  defexception message: "Forbidden", put_status: 403
end
