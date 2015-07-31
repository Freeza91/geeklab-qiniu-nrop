class User < ActiveRecord::Base
end

class Tester < User
  default_scope { where(role: ['tester', 'both']) }
end