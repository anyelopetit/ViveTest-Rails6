class CreateLoaders < ActiveRecord::Migration[6.0]
  def change
    create_table :loaders do |t|
      t.json :failed_products, array: true, default: []

      t.timestamps
    end
  end
end
