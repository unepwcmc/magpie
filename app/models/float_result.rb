class FloatResult < Result
  def fetch
    self.value = calculation.project_layer.fetch_result(self)
    save
  end
end
