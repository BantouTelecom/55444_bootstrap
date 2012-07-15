require 'sinatra'
require 'redis'
require 'mongo'

Encoding.default_external = "utf-8"

#http://localhost:9292?mobile=0786cb947aac3fa602ed4a3d351a435c&region=karnataka&key=0d85a9e73a242efd320a8c76f6019b53&message=Hello%20World

if ENV['MONGOHQ_URL']
	uri = URI.parse(ENV['MONGOHQ_URL'])
	conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
	db = conn.db(uri.path.gsub(/^\//, ''))
else
  	db = Mongo::Connection.new('localhost').db('app_name')
end

configure do
	require 'redis'
	redis_uri = (ENV["REDISTOGO_URL"]) || 'redis://localhost:6379'
	uri = URI.parse(redis_uri)
	REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

get '/' do
	params[:timestamp] = Time.now
	user = params[:mobile] if params[:mobile]
	region = params[:region] if params[:region]
	key = params[:key] if params[:key]
	message = params[:message].gsub("+"," ") if params[:message]
	
end




