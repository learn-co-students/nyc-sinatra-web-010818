class ChangeYearToInt < ActiveRecord::Migration[5.1]
  def change
    change_column(:landmarks, :year_completed, :string)
  end
end
