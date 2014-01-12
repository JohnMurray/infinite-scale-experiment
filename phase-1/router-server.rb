require 'json'
require 'bundler'
require 'net/http'

Bundler.require(:default)

require_relative 'shard/key-range'
require_relative 'shard/key'

class Router < Sinatra::Base

  # Public: Setup all the routes for the router dynamically.
  #
  # Returns nothing, but has side-effect of creating some number of
  # routes within the newly created Sinatra instance.
  def initialize
    super()

    @config = {
      campaign: {
        shards: [
          [
            Shard::KeyRange.new('a', 'm'),
            {host: 'localhost', port: 3001}
          ],
          [
            Shard::KeyRange.new('n', 'z'),
            {host: 'localhost', port: 3002}
          ]
        ]
      }
    }

    [:get, :put, :post, :delete].each do |method|
      Router.send(method, '/*/:shard') do
        service = params[:splat].first
        shard   = params[:shard]

        if @config[service.to_sym]
          match = @config[service.to_sym][:shards].select { |kr, _|
            kr.include? (Shard::Key.new(shard))
          }.first

          if match 
            to = match.last
            STDERR.puts "Matched #{to}"
            # redirect "http://#{to[:host]}:#{to[:port]}/#{service}/#{shard}"
            url = "http://#{to[:host]}:#{to[:port]}/#{service}/#{shard}"
            net_forward(url, method, request.body.read)
          end
        end

      end
    end
  end


  def net_forward(url, method, body=nil)
    uri = URI(url)
    req = case method
          when :put
            r = Net::HTTP::Put.new(uri)
            r.body = body unless body.empty?
            r.content_type = 'application/json' unless body.empty?
            r
          when :post
            Net::HTTP::Post.new(uri)
            r.body = body unless body
            r.content_type = 'application/json' unless body.empty?
            r
          when :delete
            Net::HTTP::Delete.new(uri)
          else
            Net::HTTP::Get.new(uri)
          end

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end

    res.body
  end


end
