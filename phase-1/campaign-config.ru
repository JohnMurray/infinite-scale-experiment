require_relative 'campaign-server'

shard = ENV['SHARD']

app = CampaignApp.new(shard)
run app