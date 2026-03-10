class CreateMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages do |t|
      t.references :session, null: false, foreign_key: true
      t.string :role, null: false
      t.text :content, null: false
      t.timestamps
    end

    add_check_constraint :messages, "role IN ('user', 'assistant')"
  end
end
