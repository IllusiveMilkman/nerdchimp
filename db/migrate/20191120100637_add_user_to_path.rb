class AddUserToPath < ActiveRecord::Migration[5.2]
  def change
    add_reference :paths, :user, foreign_key: true
  end
end
