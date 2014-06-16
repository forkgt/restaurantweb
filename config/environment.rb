# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load the app_config.yml file
#APP_CONFIG = YAML.load_file(Rails.root.join('config', 'app_config.yml'))[Rails.env]
# Load the app_config.yml file and read erb
APP_CONFIG = YAML.load(ERB.new(File.read(Rails.root.join('config', 'app_config.yml'))).result)[Rails.env]

# Initialize the Rails application.
Ibm::Application.initialize!
