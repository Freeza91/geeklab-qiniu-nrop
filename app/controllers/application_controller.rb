class ApplicationController < MyApp

  get  '/' do
    p "hello "
    redirect '/test'
  end

  get '/test' do
    slim :'/uploader'
  end

end
