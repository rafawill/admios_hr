module DeveloperHelper
	def get_skill_type(skill_type)
		skill_clase = case skill_type.to_i
		when 0
			'tbody_language-skill'
		when 1
			'tbody_framework-skill'	
		when 2
			'tbody_data-skill'
		when 3
		    'tbody_mobile-skill'		
		end
	end	
end
