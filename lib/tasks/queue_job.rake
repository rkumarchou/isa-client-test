namespace :queue_job do
  # TASK rails "queue_job:create[Job name1, high]"
  task :create, %i[name priority] => [:environment] do |_, args|
    queue_job = QueueJob.new(name: args[:name], priority: args[:priority])
    puts ActiveModelSerializers::SerializableResource.new(queue_job, serializer: QueueJobSerializer).to_json if queue_job.save
  end

  # TASK rails "queue_job:complete[2]"
  task :complete, %i[job_id] => [:environment] do |_, args|
    queue_job = QueueJob.find_by_id args[:job_id]
    return unless queue_job && !queue_job.completed?

    Movie.run if queue_job.update_column(:status, "completed")
    puts ActiveModelSerializers::SerializableResource.new(queue_job, serializer: QueueJobSerializer).to_json
  end
end
