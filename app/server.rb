require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'sinatra/partial'

require_relative 'data_mapper_setup'
require_relative 'helpers/application'

require_relative 'models/link'
require_relative 'models/tag'
require_relative 'models/user'

require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/application'

DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'

use Rack::Flash
post '/set-flash' do
  flash[:notice] = "Thanks for signing up!"
  flash[:notice] # => "Thanks for signing up!"
  flash.now[:notice] = "Thanks for signing up!"
end

set :partial_template_engine, :erb

use Rack::MethodOverride