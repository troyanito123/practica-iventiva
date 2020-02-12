class CreatePasswordResets < ActiveRecord::Migration[6.0]
  def change
    create_table :password_resets do |t|

      t.timestamps
    end
  end
end
