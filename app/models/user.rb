class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :encrypted_password
  field :salt
  field :_id, type: String, default: -> { name }

  attr_accessor :password

  index({ name: 1 }, { unique: true })
  validates :name, presence: true, uniqueness: true

  before_save :encrypt_password

  INVISIBLE_ITEMS = ['_id', 'created_at', 'updated_at', 'encrypted_password', 'salt']

  def self.new(params)
    user_params = params.reject {|field| ['controller', 'action'].include?(field) }
    super(user_params)
  end

  def update_attributes(params)
    user_params = params.reject {|field| ['controller', 'action'].include?(field) }
    super(user_params)
  end

  def authenticate(password)
    self.encrypted_password == BCrypt::Engine.hash_secret(password, self.salt)
  end

  def items
    attributes.reject {|field| INVISIBLE_ITEMS.include?(field) }
  end

  private

  def encrypt_password
    if @password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(@password, self.salt)
    end
  end
end
