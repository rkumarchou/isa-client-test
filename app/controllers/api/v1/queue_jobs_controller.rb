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

      # GET api/v1/schedule_workers
      # Query Params job_ids = 1,2,3
      def schedule_workers
        if params[:job_ids].present?
          QueueJobWorker.perform_async(params[:job_ids].split(','))
          render json: { data: Time.current }
        else
          render json: { error: "Please provide valid job_ids" }
        end
      end

      private

      def queue_job_params
        params.permit(:name, :priority)
      end
    end
  end
end
