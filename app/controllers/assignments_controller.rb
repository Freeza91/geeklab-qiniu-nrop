class AssignmentsController < MyApp

  helpers ApplicationHelper
  helpers AssignmentHelper

  before do
    welcome?
  end

  post '/callback_from_qiniu_video_images' do

    if params[:code].to_s == '0' && tester = Tester.find_by(id: params[:tester_id])
      if assignment = tester.assignments.find_by(id: params[:assignment_id])
        key = params[:items].first[:key]
        assignment.update_attribute(:is_sexy, true) if SoraAoi(key)
        code, result, response_headers = Qiniu::Storage.delete(
          'video-images',
          key
        )
        "Thanks SoraAoi"
      else
        "没有找到assignment"
      end
    else
      "没有找到tester"
    end

  end

end