class VisitsController < InheritedResources::Base
  respond_to :js, :html, :json

  def index
    @visit = Visit.create!(uuid: SecureRandom.uuid)
  end

  def update
    @visit = Visit.where(uuid: visit_params[:uuid]).first
    @visit.update(visit_params)
    render 'visits/questions_submitted'
  end

  def photo
    @visit = Visit.where(uuid: visit_params[:uuid]).first
    @visit.update(photo_file: visit_params[:photo_file])
    age = PredictAgeService.new(@visit).call
    byebug
  end

  def visit_params
    params.require(:visit)
          .permit(:person,
                  :photo_file,
                  :visit_dttm,
                  :audio_threshold,
                  :audio_error,
                  :uuid,
                  :nationality,
                  :gender,
                  :parent_origin,
                  :birthday_year,
                  :birthday_month)
  end
end
