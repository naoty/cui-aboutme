class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :_id, type: String, default: -> { name }

  index({ name: 1 }, { unique: true })
  validates :name, presence: true, uniqueness: true
end
