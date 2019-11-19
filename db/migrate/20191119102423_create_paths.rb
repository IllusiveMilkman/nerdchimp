class CreatePaths < ActiveRecord::Migration[5.2]
  def change
    create_table :paths do |t|
      t.string :title

      t.timestamps
    end
  end
end
