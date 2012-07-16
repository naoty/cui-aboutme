class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :_id, type: String, default: -> { name }
end
