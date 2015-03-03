class Person < ActiveRecord::Base
 enum id_type: ['National ID', 'Passport', 'Other']
 enum countries: ['Argentina','Brasil','Bolivia', 'Colombia','Honduras','Panama','Venezuela']
 has_many :person_has_skills


 validates_presence_of :name, :last_name, :email, :cel_number , :address, :id_type, :id_number, :birth_day, :nationality



  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :small => "50x50>" },
                      :url  => "/assets/developer/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/assets/developer/:id/:style/:basename.:extension"           

  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/jpg']     

end
