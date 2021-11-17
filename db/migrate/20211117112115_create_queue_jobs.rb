class CreateQueueJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :queue_jobs do |t|
      t.string :name, limit: 30
      t.integer :priority, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
