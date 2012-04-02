class CreateDummyResources < ActiveRecord::Migration
  
  def change
    create_table :dummy_resources do |t|
      t.string :name
    end
  end
  
end
