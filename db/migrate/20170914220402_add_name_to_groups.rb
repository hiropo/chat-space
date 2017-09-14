class AddNameToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :name, :string
  end
end
rails generate model Members name:string email:string
bundle exec rails generate model member user_id:references group_id:references
