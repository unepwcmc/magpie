collection @records, :root => 'calculated_stats', :object_root => false
attributes :id => :layer_id

child :calculated_stats => :stats do
  attributes :id
  code :stat_id do |cs|
    cs.calculation.operation_id
  end
  code :display_name do |cs|
    cs.calculation.display_name
  end
  attributes :value
end
