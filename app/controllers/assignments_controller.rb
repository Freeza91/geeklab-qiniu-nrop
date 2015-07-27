class AssignmentsController < ApplicationController

  before '/' do
    p request.path_info
    pass if ["", "/show"].include? request.path_info.split('/')[1]
  end

  helpers ApplicationHelper

end