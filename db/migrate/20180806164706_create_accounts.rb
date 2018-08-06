class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :service
      t.string :username

      t.timestamps
    end
  end
end
