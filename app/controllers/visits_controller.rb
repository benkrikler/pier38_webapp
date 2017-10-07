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
    response = PredictAgeService.new(@visit).call
    @visit.update(predicted_image_age: response.parsed_response["prediction"])
    #@age = "<div id='predicted-age'>#{response.parsed_response["prediction"]}</div>".html_safe
    render 'visits/audio_test'
  end

  def visit_params
    params.require(:visit)
          .permit(:person,
                  :photo_file,
                  :visit_dttm,
                  :predicted_audio_age,
                  :predicted_image_age,
                  :audio_threshold,
                  :audio_error,
                  :uuid,
                  :nationality,
                  :gender,
                  :mother_origin,
                  :father_origin,
                  :birthday_year,
                  :birthday_month,
                  :hearing_impaired)
  end
end
