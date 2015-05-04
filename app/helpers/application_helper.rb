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

  def get_developer_image(image, developer_id, options={height: 128,width: 128})
    if FileTest.exist?("#{Rails.root}/public/assets/developer/#{developer_id}/medium/#{image}")
      image_check = image_tag("/assets/developer/#{developer_id}/medium/#{image}",options)
    else
      image_check = image_tag("/assets/images/user_male.png", options)
    end
  end  
end
