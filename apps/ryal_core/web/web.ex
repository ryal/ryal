defmodule Ryal.Web do
  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  def query do
    quote do
      import Ecto.Query
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      import Ecto
      import Ecto.Query

      import Ryal.JsonRenderPlug
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [
        get_csrf_token: 0, get_flash: 2, view_module: 1
      ]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      import Ecto
      import Ecto.Query
      import Ryal.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
