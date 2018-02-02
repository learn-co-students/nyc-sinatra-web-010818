class CreateFiguresTable < ActiveRecord::Migration[5.1]
  def change
    create_table :figures do |f|
      f.string :name
    end
  end
end
