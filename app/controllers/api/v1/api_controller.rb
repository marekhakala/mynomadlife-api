module Api::V1
  class ApiController < ActionController::Base
    serialization_scope :view_context

    rescue_from ActiveRecord::RecordNotFound, with: :record_error
    rescue_from ActiveRecord::ActiveRecordError, with: :record_error
    rescue_from ActionController::ParameterMissing, with: :record_error

    def record_error error
      render json: { status: :failed, errors: error.message }
    end

    def default_serializer_options
      { root: false }
    end
  end
end
