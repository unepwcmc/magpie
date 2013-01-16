class JsonResult < Result
  def fetch
    self.value_json = calculation.project_layer.fetch_result(self)
    save!
  end
end
