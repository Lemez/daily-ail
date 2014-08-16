class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.text :sourcetext

      t.timestamps
    end
  end
end
