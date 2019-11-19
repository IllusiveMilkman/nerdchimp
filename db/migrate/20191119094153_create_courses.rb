class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.string :url
      t.string :provider
      t.json :category
      t.integer :duration

      t.timestamps
    end
  end
end
