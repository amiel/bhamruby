class PaperclipOptions < Hash
  def self.s3_options
    if ENV['S3_ACCESS_KEY_ID'] and ENV['S3_SECRET_ACCESS_KEY'] then
      {
        :storage => :s3,
        :s3_credentials => { :access_key_id => ENV['S3_ACCESS_KEY_ID'], :secret_access_key => ENV['S3_SECRET_ACCESS_KEY'] },
        :path => ":class/:attachment/:id/:style.:extension",
        :bucket => "bhamruby-#{Rails.env}"
      }
    else
      {}
    end
  end
  
  def self.default_styles
    { } # Any consistent options can go here
  end

  def initialize(opts = {}, env = Rails.env)
    merge! self.class.s3_options if env.to_sym == :production # not using ActiveSupport::StringInquirer methods in case they pass a symbol
    merge! self.class.default_styles
    merge! opts
  end
  
end
