unless Rails.env == 'test'
  CARTODB_CONFIG = YAML.load_file(Rails.root.join('config/cartodb_config.yml'))
end
