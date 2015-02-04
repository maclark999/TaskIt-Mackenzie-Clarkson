class User < ActiveRecord::Base

  def full_name
    "#{first_name} #{last_name}"
  end

  def all_info
    "#{first_name} #{last_name} #{email}"
  end
end
