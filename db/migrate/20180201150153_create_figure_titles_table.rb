class CreateFigureTitlesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :figure_titles do |ft|
      ft.integer :figure_id
      ft.integer :title_id
    end
  end
end
