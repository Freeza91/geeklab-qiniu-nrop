class ApplicationController < MyApp

  get  '/' do
    p "hello "
    redirect '/test'
  end

  get '/test' do
    #slim :'/uploader'
    erb: '/index'
  end

  post '/upload' do
    p 'upload file'
    json = {
      msg: '上传成功'
    }
    render json: json
  end
end
