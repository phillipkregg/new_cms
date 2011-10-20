class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      #foreign key
      t.references :subject
      t.string :name
      t.string :permalink
      t.integer :position
      t.boolean :visible,    :default => false

      t.timestamps
    end
    add_index("pages", "subject_id")
    add_index("pages", "permalink")
  end

  def self.down
    drop_table :pages
  end
end
