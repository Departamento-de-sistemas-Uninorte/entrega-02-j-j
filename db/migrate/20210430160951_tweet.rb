class Tweet < ActiveRecord::Migration[6.1]
  def change
    rename_table :tweets, :tweets
  end
end