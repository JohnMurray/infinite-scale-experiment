require 'bundler'
Bundler.require(:default)
require'json'

require_relative 'db'


class CampaignApp < Sinatra::Base

  def initialize(shard)
    super()
    STDERR.puts("Campaign server started for shard: #{shard}")
    @db = DB.new('campaign', shard)
  end

  before '*' do
    STDERR.puts "Received request: #{to}"
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
