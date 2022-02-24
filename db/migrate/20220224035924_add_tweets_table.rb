class AddTweetsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :tweets do |t|
      t.string :message
      t.datetime :timestamps
  
      t.timestamps
    end
  end
end
