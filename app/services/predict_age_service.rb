class PredictAgeService

  include HTTParty
  debug_output $stdout
  base_uri "#{ENV['ML_API']}/api"

  def initialize(visit)
    @visit = visit
  end

visit.photo_file.path

  def call
    begin
      body = { model: 'Article', model_id: @article.id, text: @article.article, language_cd: @article.language_cd }
      puts body
      response = self.class.post('/parser',
                                  body: body.to_json,
                                  headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
                                )
      puts response
      return response
    rescue => e
      Rails.logger.error "[Spacy] Article parsing failed: #{@article.id}"
      raise e
    end
  end

end
