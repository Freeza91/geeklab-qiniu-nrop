module ApplicationHelper

  def welcome?
    # 微信认证方式
    return halt(401, 'timestamp is blank') if (timestamp = params[:timestamp].to_s).empty?
    return halt(401, 'nonce is blank')  if (nonce = params[:nonce].to_s).empty?
    codes = ["#{settings.secret_key_base}", timestamp, nonce].sort.join("")
    halt(401, '401 Unauthorized') unless Digest::SHA1.hexdigest(codes) == params[:signature]
  end

end