class CreateScales < ActiveRecord::Migration[5.0]
  def change
    create_table :scales do |t|
      t.column :name, :string
      t.column :notes_count, :integer

      t.timestamps
    end
    add_index :scales, :name
    add_index :scales, :notes_count
  end
end
