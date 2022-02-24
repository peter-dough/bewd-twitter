class AddSessionsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.string :token
      t.datetime :timestamps

      t.timestamps
    end
  end
end
