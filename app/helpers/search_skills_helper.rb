module SearchSkillsHelper

	def skill_color(number)
		case number.to_i
		 when 0..2	
		   content_tag(:div, nil,class: "red-skill")
		 when 3
		 	content_tag(:div, nil,class: "yellow-skill")
		 when 4..5	
		 	content_tag(:div, nil,class: "green-skill")
		end   
	end	


	def has_project(bool)
		if bool == true
		  label_tag nil, 'In Project', class: 'label label-danger'
	    else
          label_tag nil, 'Available', class: 'label label-success'
	    end	
	end	

	def fill_background(obj)

		class_color = if(obj.blank?)
			'dev-unbillabel'
		elsif (obj == 0)
			'dev-placed'
		elsif (obj == 1)
			'dev-unbillabel'
		elsif (obj == 2)
			'avalible-not-confirmed'	
		else
			'placed-not-billable'								
		end	

	end	
end
