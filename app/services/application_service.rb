class ApplicationService
  include Pagy::Backend
  # include ActiveSupport::Concern
  # extend ActiveModel::Callbacks


    def self.call(*args)
      new(*args).call
    end
  
    def call
      raise NotImplementedError, "You must define `call` as instance method in #{self.class.name} class"
    end
end