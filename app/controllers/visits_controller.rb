class VisitsController < InheritedResources::Base
  respond_to :js, :html, :json

  def index
    @visit = Visit.create!(uuid: SecureRandom.uuid)
  end

  def photo
    @visit = Visit.where(uuid: visit_params[:uuid]).first
    @visit.update(photo_file: visit_params[:photo_file])
    response = PredictImageAgeService.new(@visit).call
    @visit.update(predicted_image_age: response.parsed_response["prediction"])
    redirect_to visit_audio_path(@visit.id)
  end

  def audio
    @visit = Visit.find(params[:visit_id])
    render :audio
  end

  def audio_update
    @visit = Visit.find(params[:visit_id])
    @visit.update(audio_threshold: visit_params[:audio_threshold])
    response = PredictAudioAgeService.new(@visit).call
    @visit.update(predicted_audio_age: response.parsed_response["prediction"])
    redirect_to visit_questions_path(@visit.id)
  end

  def questions
    @visit = Visit.find(params[:visit_id])
    render :questions
  end

  def questions_update
    @visit = Visit.find(params[:visit_id])
    @visit.update(visit_params)
    redirect_to visit_result_path(@visit.id)
  end

  def result
    @visit = Visit.find(params[:visit_id])
    est_age = (@visit.predicted_audio_age + @visit.predicted_image_age) / 2
    est_age.round
    @visit.update(result: 'good')
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
                  :hearing_impaired,
                  :age)
  end
end
