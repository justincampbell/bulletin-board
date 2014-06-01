require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV']

class BulletinBoard < Sinatra::Base
  get '/' do
    redis.hget :bulletin, :bulletin
  end

  put '/' do
    authorize!
    redis.hset :bulletin, :bulletin, params[:bulletin]
    status 201
  end

  helpers do
    def auth
      @auth ||= Rack::Auth::Basic::Request.new(request.env)
    end

    def authorize!
      halt 401 unless auth.credentials == ['user', 'pass']
    end

    def redis
      $redis ||= Redis.new
    end
  end
end
