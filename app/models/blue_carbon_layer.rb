class BlueCarbonLayer < ProjectLayer
  def self.get_operations
    return [{
        name: "sum",
        display_name: "Sum"
      }]
  end
end
