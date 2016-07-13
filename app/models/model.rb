class Model < ActiveRecord::Base

  def self.by_make_id(make_id)
    where(make_id: make_id)
  end

end
