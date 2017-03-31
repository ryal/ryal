defmodule Ryal.JsonApiQuery do
  @moduledoc """
  A collection of queries for working with the JSON API format. You can filter
  and sort data using this module.
  """

  use Ryal.Web, :query

  def filter(collection, filter_params, view) do
    filter_attrs = format_filter(filter_params, attributes(view))
    if Enum.any? filter_attrs do
      [{key, value}] = filter_attrs
      from c in collection,
        where: field(c, ^key) in ^value
    else
      collection
    end
  end

  defp format_filter(params, attrs) do
    format_list (params || %{}), fn(map) ->
      {key, value} = map
      key = String.to_atom key
      value = String.split(value, ",")

      if Enum.member?(attrs, key), do: {key, value}
    end
  end

  def sort(collection, sort_params, view) do
    sort_attrs = format_sort(sort_params, attributes(view))
    if Enum.any?(sort_attrs) do
      from c in collection, order_by: ^sort_attrs
    else
      collection
    end
  end

  defp format_sort(params, attrs) do
    params = String.split(params || "", ",")
    format_list params, fn(attr) ->
      order = if String.match?(attr, ~r/\A-/), do: :desc, else: :asc
      attr = attr |> String.replace(~r/\A-/, "") |> String.to_atom
      if Enum.member?(attrs, attr), do: {order, attr}
    end
  end

  defp attributes(view) do
    [:id] ++ view.__attributes
  end

  defp format_list(params, format_fun) do
    params
    |> Enum.map(format_fun)
    |> Enum.reject(&(&1 == nil))
  end
end
