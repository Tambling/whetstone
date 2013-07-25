class CreateResources < ActiveRecord::Migration
  def change
  	create_table :resources do |t|
  		t.string :title
  		t.text :description
  		t.string :url
  		t.references :stones
  	end
  end
end
