class CreateIntercommunalities < ActiveRecord::Migration[5.0]
  def change
    create_table :intercommunalities do |t|
      t.string :name
      t.string :department
      t.string :fisc
      t.string :form
      t.integer :siren

      t.timestamps
    end
  end
end
