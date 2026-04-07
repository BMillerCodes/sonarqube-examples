require_relative '../models/user'
require_relative '../models/order'

class UserService
  def initialize
    @users = []
    @user_id_counter = 1
  end

  def create_user(name, email, age = 18)
    user = User.new(name, email, age)
    @users << user
    user
  end

  def find_user(id)
    @users.find { |u| u.id == id }
  end

  def find_user_by_email(email)
    @users.find { |u| u.email == email }
  end

  def all_users
    @users.dup
  end

  def update_user(id, attributes)
    user = find_user(id)
    return nil unless user

    user.name = attributes[:name] if attributes[:name]
    user.email = attributes[:email] if attributes[:email]
    user.age = attributes[:age] if attributes[:age]
    user
  end

  def delete_user(id)
    @users.delete_if { |u| u.id == id }
  end

  def activate_user(id)
    user = find_user(id)
    user&.activate
  end

  def deactivate_user(id)
    user = find_user(id)
    user&.deactivate
  end

  def count
    @users.length
  end

  def list_active_users
    @users.select(&:active)
  end

  def list_admin_users
    @users.select(&:is_admin?)
  end

  def validate_user(name, email)
    # Duplicate code: similar validation in other services
    return false if name.nil? || name.strip.empty?
    return false if email.nil? || !email.include?('@')
    true
  end
end