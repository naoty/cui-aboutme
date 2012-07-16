class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :encrypted_password
  field :_id, type: String, default: -> { name }

  attr_accessor :password, :salt

  index({ name: 1 }, { unique: true })
  validates :name, presence: true, uniqueness: true

  before_save :encrypt_password

  INVISIBLE_ITEMS = ['_id', 'created_at', 'updated_at', 'encrypted_password']

  def items
    attributes.reject {|attr| INVISIBLE_ITEMS.include?(attr) }
  end

  private

  def encrypt_password
    if @password.present?
      @salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(@password, @salt)
    end
  end
end
