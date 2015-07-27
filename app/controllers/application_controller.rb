class ApplicationController < MyApp

  helpers ApplicationHelper

  get  '/' do
    put_policy = Qiniu::Auth::PutPolicy.new(
        'geeklac',     # 存储空间
        'hello'        # 最终资源名，可省略，即缺省为“创建”语义
    )

    p uptoken = Qiniu::Auth.generate_uptoken(put_policy)
  end

end
