class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :invited_user_id
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
