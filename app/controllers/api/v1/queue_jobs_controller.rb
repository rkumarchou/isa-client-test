module Api
  module V1
    class QueueJobsController < ApplicationController
      # GET api/v1/queue_jobs
      def index
        params[:page] = 1 unless params[:page].present?
        queue_jobs = QueueJob.all.order(priority: :desc).paginate(page: params[:page])
        render json: { data: ActiveModelSerializers::SerializableResource.new(queue_jobs, each_serializer: QueueJobSerializer) }
      end

      # POST api/v1/queue_jobs
      def create
        queue_job = QueueJob.new(queue_job_params)

        if queue_job.save
          render json: { queue_job: ActiveModelSerializers::SerializableResource.new(queue_job, serializer: QueueJobSerializer) }
        else
          render json: { error: queue_job.errors.full_messages.first }
        end
      end

      # GET api/v1/worker
      def worker
        queue_job = QueueJob.find_by_id(params[:id])
        if queue_job && !queue_job.completed?
          QueueJobWorker.perform_async(queue_job.id)
          render json: { data: Time.current }
        else
          render json: { error: queue_job.present? ? "Job already processed." : "Job does't exist" }
        end
      end

      private

      def queue_job_params
        params.permit(:name, :priority)
      end
    end
  end
end
