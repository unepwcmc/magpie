module ProjectLayerHelper
  def format_providers_list_for_select provider_list
    provider_list.map { |r| [r['display_name'], r['id']] }
  end

  def format_operations_list_for_select operations_list
    operations_list.map { |r| [r['display_name'], r['name']] }
  end
end
