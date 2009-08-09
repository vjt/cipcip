require 'rubygems'
require 'sinatra'
require 'sinatra/content_for'
#require 'ruby-debug'

configure do
  load 'lib/boot.rb'
  require 'lib/models'
end

helpers do
  def title(string)
    content_for(:title) { string }
  end
end

enable :sessions

get '/' do
  session = UserSession.find
  unless session
    erb :login
  else
    redirect '/timeline'
  end
end

post '/' do
  session = UserSession.create :username => params['username'],
    :password => params['password'], :remember_me => true
  redirect '/'
end

get '/logout' do
  session = UserSession.find
  if session
    session.user.forget!
    session.destroy
  end
  redirect '/'
end

post '/tweet' do
  session = UserSession.find
  unless session
    redirect '/'
  else
    Tweet.create(:user => session.user, :body => params[:body])
    redirect '/timeline'
  end
end

get '/timeline' do
  session = UserSession.find
  unless session
    redirect '/'
  else
    @tweets = Tweet.by_date.find(:all, :limit => 20)
    @user = session.user
    erb :timeline
  end
end
