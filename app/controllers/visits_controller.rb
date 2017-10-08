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
    if @visit.predicted_audio_age.present?
      audio_age = @visit.predicted_audio_age
    else
      audio_age = 1
    end
    if @visit.predicted_image_age.present?
      image_age = @visit.predicted_image_age
    else
      image_age = 1
    end
    est_age = (audio_age + image_age) / 2
    est_age.round
    age = @visit.age
    if age.present?
      age.round
    else
      age = 1
    end
    result = 'good'
    if est_age.between?(age - 3, age + 3)
      result = 'good'
    end
    if est_age.between?(age - 5, age + 5)
      result = 'bad'
    end
    if (age > est_age + 5) || (age < est_age - 5)
      result = 'ugly'
    end
    @visit.update(result: result, estimated_age: est_age)
    redirect_to visit_result_path(@visit.id)
  end

  def result
    @visit = Visit.find(params[:visit_id])
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
