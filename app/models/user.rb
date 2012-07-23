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
  validates :name, presence: true, uniqueness: true, exclusion: { in: RESERVED_NAMES }, format: { with: /^\w+$/ }

  before_save :encrypt_password, :slice_items, :remove_items

  def self.find_by_slug(id)
    hyphenized_id = id.gsub(/_/) { '-undscr-' }
    self.find(hyphenized_id)
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

  def slice_items
    ['controller', 'action', 'format'].each {|params| self.unset(params) }
  end

  def remove_items
    self.attributes.each do |f, v|
      self.unset(f) if !UNLISTED_ITEMS.include?(f) && v.blank?
    end
  end

end
