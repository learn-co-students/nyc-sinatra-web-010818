class CreateLandmarksTable < ActiveRecord::Migration[5.1]
  def change
    create_table :landmarks do |l|
      l.string :name
      l.integer :year_completed
      l.integer :figure_id
    end
  end
end
