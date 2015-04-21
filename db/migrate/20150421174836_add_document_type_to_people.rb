class AddDocumentTypeToPeople < ActiveRecord::Migration
  def change
    change_table :people do |t|
        t.references :document_type
    end
  end

end
