class AddPromptToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :prompt, :string
    add_column :messages, :key_prompt, :string
  end
end
