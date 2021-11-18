module Api
  module V1
    class QueueJobsController < ApplicationController
      # GET api/v1/queue_jobs
      def index
        queue_jobs = QueueJob.all.order(priority: :desc)
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

      private

      def queue_job_params
        params.permit(:name, :priority)
      end
    end
  end
end
