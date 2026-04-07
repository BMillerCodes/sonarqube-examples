require_relative '../src/services/user_service'

describe UserService do
  let(:service) { UserService.new }

  describe '#create_user' do
    it 'creates a user with given attributes' do
      user = service.create_user('John Doe', 'john@example.com', 25)
      expect(user.name).to eq('John Doe')
      expect(user.email).to eq('john@example.com')
      expect(user.age).to eq(25)
    end

    it 'uses default age when not provided' do
      user = service.create_user('Jane Doe', 'jane@example.com')
      expect(user.age).to eq(18)
    end
  end

  describe '#find_user' do
    it 'finds user by id' do
      user = service.create_user('John', 'john@example.com')
      found = service.find_user(user.id)
      expect(found).to eq(user)
    end

    it 'returns nil for non-existent id' do
      found = service.find_user(9999)
      expect(found).to be_nil
    end
  end

  describe '#find_user_by_email' do
    it 'finds user by email' do
      user = service.create_user('John', 'john@example.com')
      found = service.find_user_by_email('john@example.com')
      expect(found).to eq(user)
    end
  end

  describe '#update_user' do
    it 'updates user attributes' do
      user = service.create_user('John', 'john@example.com')
      updated = service.update_user(user.id, { name: 'John Updated', age: 30 })
      expect(updated.name).to eq('John Updated')
      expect(updated.age).to eq(30)
    end
  end

  describe '#delete_user' do
    it 'deletes user by id' do
      user = service.create_user('John', 'john@example.com')
      service.delete_user(user.id)
      expect(service.find_user(user.id)).to be_nil
    end
  end

  describe '#activate_user and #deactivate_user' do
    it 'activates and deactivates user' do
      user = service.create_user('John', 'john@example.com')
      service.deactivate_user(user.id)
      expect(user.active).to be false
      service.activate_user(user.id)
      expect(user.active).to be true
    end
  end

  describe '#count' do
    it 'returns total number of users' do
      service.create_user('User1', 'user1@example.com')
      service.create_user('User2', 'user2@example.com')
      expect(service.count).to eq(2)
    end
  end

  describe '#list_active_users' do
    it 'returns only active users' do
      user1 = service.create_user('User1', 'user1@example.com')
      user2 = service.create_user('User2', 'user2@example.com')
      service.deactivate_user(user1.id)
      active = service.list_active_users
      expect(active.length).to eq(1)
      expect(active[0].name).to eq('User2')
    end
  end

  describe '#validate_user' do
    it 'returns true for valid name and email' do
      expect(service.validate_user('John', 'john@example.com')).to be true
    end

    it 'returns false for nil name' do
      expect(service.validate_user(nil, 'john@example.com')).to be false
    end

    it 'returns false for empty name' do
      expect(service.validate_user('', 'john@example.com')).to be false
    end

    it 'returns false for email without @' do
      expect(service.validate_user('John', 'invalid-email')).to be false
    end
  end
end