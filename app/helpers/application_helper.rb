module ApplicationHelper

  def admin_user
    admin_user = false
    if current_member
      if current_member.id == 1
        admin_user = true
      end
    end
    return admin_user
  end

end
