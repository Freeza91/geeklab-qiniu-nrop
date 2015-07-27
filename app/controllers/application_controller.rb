class ApplicationController < MyApp

  helpers ApplicationHelper

  get  '/' do
    "hello"
  end

end
