class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.column :frequency, :float
      t.column :scale_id, :integer
      t.column :parent_id, :integer
      t.column :name, :string
    end
  end
end
