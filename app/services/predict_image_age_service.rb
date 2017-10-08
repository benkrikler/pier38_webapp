class PredictImageAgeService

  include HTTParty
  debug_output $stdout
  base_uri "#{ENV['CAFFE_SERVER']}"

  def initialize(visit)
    @visit = visit
  end

  def call
    body = { prediction_uuid: @visit.uuid, image_s3_key: @visit.photo_file.path }
    response = self.class
                   .get('/api/predict',
                        body: body.to_json,
                        headers: { 'Content-Type' => 'application/json',
                                   'Accept' => 'application/json' })
    Rails.logger.debug("Caffe API response: #{response}")
    return response
  end

end
