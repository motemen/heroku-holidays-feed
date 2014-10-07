require 'sinatra'
require 'builder'
require 'redis'
require 'json'

redis = Redis.new(url: ENV['REDISTOGO_URL'] || 'redis://localhost:6379')

get '/' do
  redirect 'http://misc.tokyoenvious.net/holidays/holidays.html'
end

get '/rss' do
  keys = redis.keys.sort.reverse.first(30)

  @entries = if keys.empty?
    []
  else
    redis.mget(keys).map do |v|
      JSON.parse(v)
    end
  end

  # ?d=7,3,2,1,0
  if d = params[:d]
    rr = d.split(/,/).map do |d|
      if d == '0'
        /^\D+$/
      elsif /^\d+$/ === d
        %r( #{d} )
      else
        /(?!)/
      end
    end

    @entries.select! do |entry|
      rr.any? { |r| r === entry['body'] }
    end
  end

  p @entries

  content_type 'text/xml'
  builder :rss
end