class CreateSchemaInfo < ActiveRecord::Migration[7.2]
  def change
    create_table :schema_migrations do |t|
      t.string :version
    end
  end
end
