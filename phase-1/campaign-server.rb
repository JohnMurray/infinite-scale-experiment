require 'bundler'
Bundler.require(:default)
require'json'

require_relative 'db'


class CampaignApp < Sinatra::Base
  def initialize
    super()
    env = ENV['RACK_ENV']
    STDERR.puts("Campaign server started for shard: #{env}")
    @db = DB.new('campaign', env)
  end

  get '/campaign/:id' do
    @db.find(params['id']).to_json
  end

  put '/campaign/:id' do
    data = JSON.parse(request.body.read)
    @db.store(params['id'], data)
  end

  post '/campaign' do
    id = Time.now.to_i.to_s
    @db.store(id, JSON.parse(request.body.read))
  end

  delete '/campaign/:id' do
    @db.delete(params['id'])
  end
end
