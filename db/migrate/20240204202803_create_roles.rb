class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.string "movie_id"
      t.string "actor_id"
      t.string "character_name"
      t.timestamps
    end
  end
end
