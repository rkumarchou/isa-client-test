class QueueJobWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(job_id)
    queue_job = QueueJob.find_by_id(job_id)
    return unless queue_job && !queue_job.completed?

    queue_job.update_column(:status, 'in_progress')
    sleep 5
    Movie.run if queue_job.update_column(:status, 'completed')
  end
end
