class PredictAudioAgeService

  include HTTParty
  debug_output $stdout
  base_uri "#{ENV['CAFFE_SERVER']}"

  def initialize(visit)
    @visit = visit
  end

  def call
    body = { audio_threshold: @visit.audio_threshold }
    response = self.class
                   .get('/api/audio',
                        body: body.to_json,
                        headers: { 'Content-Type' => 'application/json',
                                   'Accept' => 'application/json' })
    Rails.logger.debug("Audio API response: #{response}")
    return response
  end

end
