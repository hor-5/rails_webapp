class CreatePersonas < ActiveRecord::Migration[6.1]
  def change
    create_table :personas do |t|
      t.integer :dni
      t.string :nombre
      t.string :apellido
      t.date :fecha_nac

      t.timestamps
    end
  end
end
