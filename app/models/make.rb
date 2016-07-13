class Make < ActiveRecord::Base
  
  def self.by_webmotor_id(webmotors_make_id)
    where(webmotors_id: webmotors_make_id)[0]
  end

  def self.by_name(name)
    where(name: name)
  end

end
