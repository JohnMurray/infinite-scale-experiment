require 'bundler'
Bundler.require(:default)

class Router < Sinatra::Base

  # Public: Setup all the routes for the router dynamically.
  #
  # Returns nothing, but has side-effect of creating some number of
  # routes within the newly created Sinatra instance.
  def initialize
    super()

    [:get, :put, :post, :delete].each do |method|
      Router.send(method, '*') do
        "hello from method: #{method}"
      end
    end
  end

end
