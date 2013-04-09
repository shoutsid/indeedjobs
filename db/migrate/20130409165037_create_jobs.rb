class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :radius
      t.string :job_key
      t.string :jobtitle
      t.string :company
      t.string :city
      t.string :description
      t.string :url
      t.date :posted
      t.boolean :expired

      t.timestamps
    end
  end
end
