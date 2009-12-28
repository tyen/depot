class AddRelationshipProductAndUser < ActiveRecord::Migration
  def self.up
    add_column :product, :user_id, :integer, :null => false
  end

  def self.down
  end
end
