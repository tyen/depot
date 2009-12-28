class AddRelationshipBetweenUserAndLineItem < ActiveRecord::Migration
  def self.up
    add_column :line_items, :user_id, :integer, :null => false
  end

  def self.down
  end
end
