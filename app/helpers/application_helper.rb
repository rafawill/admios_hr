module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def skill_badge(rating)

  	case rating.to_i
		 when 0..2	
		   content_tag(:span, rating,class: "badge-danger")
		 when 3
		 	content_tag(:span, rating,class: "badge-warning")
		 when 4..5	
		 	content_tag(:span, rating,class: "badge-success")
	  end 
  end

  def get_developer_image(image, developer_id)
    if FileTest.exist?("#{Rails.root}/public/assets/developer/#{developer_id}/medium/#{image}")
      image_path = "/assets/developer/#{developer_id}/medium/#{image}"
    else
      image_path = "/assets/images/user_male.png"
    end
  end  

  def date_present(date)
    return "Present" if date.to_date > Date.today
    return date.try(:strftime, "%b %d, %Y")
  end  
end
