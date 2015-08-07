class ApplicationController < MyApp

  get  '/' do
    p "hello "
    redirect '/test'
  end

  get '/uploader' do
    erb :'/uploader'
  end

  post '/upload' do
    json = {
      msg: '上传成功'
    }.to_json
  end
end
