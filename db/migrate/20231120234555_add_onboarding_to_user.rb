class AddOnboardingToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :onboard, :integer, default: 0
  end
end
