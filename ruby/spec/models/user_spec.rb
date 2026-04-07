require_relative '../src/models/user'

describe User do
  describe '#initialize' do
    it 'creates a user with name and email' do
      user = User.new('John Doe', 'john@example.com')
      expect(user.name).to eq('John Doe')
      expect(user.email).to eq('john@example.com')
    end

    it 'sets default age to 18' do
      user = User.new('Jane Doe', 'jane@example.com')
      expect(user.age).to eq(18)
    end

    it 'sets default active to true' do
      user = User.new('Bob', 'bob@example.com')
      expect(user.active).to be true
    end

    it 'sets default role to user' do
      user = User.new('Alice', 'alice@example.com')
      expect(user.role).to eq('user')
    end
  end

  describe '#full_name' do
    it 'returns uppercase name' do
      user = User.new('john doe', 'john@example.com')
      expect(user.full_name).to eq('JOHN DOE')
    end
  end

  describe '#validate' do
    it 'returns true for valid user' do
      user = User.new('John', 'john@example.com')
      expect(user.validate).to be true
    end

    it 'returns false for nil name' do
      user = User.new(nil, 'john@example.com')
      expect(user.validate).to be false
    end

    it 'returns false for empty email without @' do
      user = User.new('John', 'invalid-email')
      expect(user.validate).to be false
    end
  end

  describe '#activate and #deactivate' do
    it 'activates user' do
      user = User.new('John', 'john@example.com')
      user.deactivate
      user.activate
      expect(user.active).to be true
    end

    it 'deactivates user' do
      user = User.new('John', 'john@example.com')
      user.deactivate
      expect(user.active).to be false
    end
  end

  describe '#is_admin?' do
    it 'returns false for regular user' do
      user = User.new('John', 'john@example.com')
      expect(user.is_admin?).to be false
    end
  end

  describe '#greet' do
    it 'returns greeting message' do
      user = User.new('John', 'john@example.com')
      expect(user.greet).to include('Welcome')
    end
  end
end