class CreateInvitations < ActiveRecord::Migration[5.0]
  def change
    create_table :invitations do |t|
      t.integer :team_id
      t.string :user_email
      t.integer :invited_by_user_id
      t.string :token, unique: true
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
