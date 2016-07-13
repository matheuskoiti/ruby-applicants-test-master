class Model < ActiveRecord::Base

  def self.by_make_id(make_id)
    where(make_id: make_id)
  end

  def self.by_name_and_make_id(name, make_id)
    where(name: name, make_id: make_id)
  end

  def self.contains?(name, make_id)
    by_name_and_make_id(name, make_id).size != 0
  end

end
