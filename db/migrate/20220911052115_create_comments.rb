class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      # can not use foreign key constraints
      t.references :article

      t.timestamps
    end
  end
end
