$:.unshift '.'
require 'config/environment'

use Rack::Static, :urls => ['/css'], :root => 'public' # Rack fix allows seeing the css folder.


if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending run `rake db:migrate` to resolve the issue.'
end



require_relative 'app/controllers/figures_controller'
require_relative 'app/controllers/landmarks_controller'
require_relative 'app/controllers/application_controller'


use Rack::MethodOverride
use LandmarksController
use FiguresController
run ApplicationController
