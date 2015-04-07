class User < ActiveRecord::Base
  enum role: [:user, :developer, :admin]

  validates_presence_of :name, :last_name, :address, :phone, :cell_phone, :image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :small => "50x50>" },
                      :url  => "/assets/user/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/assets/user/:id/:style/:basename.:extension"           

  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/jpg']     

end
