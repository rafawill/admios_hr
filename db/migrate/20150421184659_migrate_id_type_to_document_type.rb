class MigrateIdTypeToDocumentType < ActiveRecord::Migration
  def change
      DocumentType.destroy_all
      national_id = DocumentType.create :name => 'National ID'
      passport    = DocumentType.create :name => 'Passport'
      other       = DocumentType.create :name => 'Other'

      Person.find_each do |person|
          person.document_type = national_id if person.id_type.to_i == 0
          person.document_type = passport    if person.id_type.to_i == 1
          person.document_type = other       if person.id_type.to_i == 2
          person.save!
      end
  end
end
