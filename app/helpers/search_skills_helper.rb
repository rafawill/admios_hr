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
end
