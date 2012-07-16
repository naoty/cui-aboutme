class User
  include Mongoid::Document
  include Mongoid::Timestamps

  UNLISTED_ITEMS = ['_id', 'name', 'created_at', 'updated_at', 'encrypted_password', 'salt']
  RESERVED_NAMES = ['users', 'signup']

  field :name
  field :encrypted_password
  field :salt

  # for 3.x
  # field :_id, type: String, default: -> { name }

  # for 2.x
  key :name

  attr_accessor :password

  index({ name: 1 }, { unique: true })
  validates :name, presence: true, uniqueness: true, exclusion: { in: RESERVED_NAMES }

  before_save :encrypt_password

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
    attributes.reject {|field| UNLISTED_ITEMS.include?(field) }
  end

  private

  def encrypt_password
    if @password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(@password, self.salt)
    end
  end
end
