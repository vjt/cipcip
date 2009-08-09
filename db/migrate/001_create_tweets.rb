class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :user
      t.string :body, :limit => 140

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
