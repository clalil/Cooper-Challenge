class CreateBmiData < ActiveRecord::Migration[5.2]
  def change
    create_table :bmi_data do |t|
      t.references :user, foreign_key: true
      t.hstore :data

      t.timestamps
    end
  end
end
