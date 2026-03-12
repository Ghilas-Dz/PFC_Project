defmodule BackendWeb.ErrorJSON do
  def render(template, assigns) do
    %{
      errors: %{
        detail: assigns[:message] || Phoenix.Controller.status_message_from_template(template)
      }
    }
  end
end
