module AssignmentHelper

  def SoraAoi(image)
    image_url = "http://#{settings.qiniu_video_images_domain}/" + image
    res = RestClient.get(image_url + '?nrop')
    body = JSON.parse res.body
    return true if body['code'] == 0 && body['fileList'].first['label'] == 0
    false
  end

end
