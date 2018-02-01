class ChangeYearBackToInt < ActiveRecord::Migration[5.1]
  def change
    change_column(:landmarks, :year_completed, :integer)
  end
end
