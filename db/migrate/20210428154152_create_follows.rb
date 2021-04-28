class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :follow_id

      t.timestamps
    end

    add_index(:follows, [:user_id, :follow_id], :unique => true)
    add_index(:follows, [:follow_id, :user_id], :unique => true)
  end
end
