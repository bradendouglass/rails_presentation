class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :description
      t.integer :urgency
      t.references :user

      t.timestamps
    end
  end
end
