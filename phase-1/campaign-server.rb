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
    res = @db.store(params['id'], data)

    {id: res}.to_json
  end

  post '/campaign/:id' do
    id = params[:id]
    data = JSON.parse(request.body.read)
    res = @db.store(id, data)
    {id: res}.to_json
  end

  delete '/campaign/:id' do
    @db.delete(params['id'])
  end
end
