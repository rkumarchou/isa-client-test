class QueueJobWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(job_ids)
    queue_jobs = QueueJob.where(id: job_ids, status: 'waiting')
    waiting_ids = queue_jobs.pluck(:id)
    queue_jobs.update_all(status: 'in_progress')

    QueueJob.where(id: waiting_ids).order(priority: :desc).each do |job| 
      Movie.run if job.update_column(:status, 'completed')
    end
  end
end
