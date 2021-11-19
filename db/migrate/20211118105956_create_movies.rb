class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title, limit: 30

      t.timestamps
    end
  end
end
