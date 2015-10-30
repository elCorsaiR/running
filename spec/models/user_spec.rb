require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(email: 'user@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:name) }
  it { should respond_to(:level_id) }
  it { should respond_to(:sport_id) }
  it { should respond_to(:distance_id) }
  it { should respond_to(:report_dat) }
  it { should respond_to(:birthday) }
  it { should respond_to(:gender_id) }
  it { should respond_to(:weight) }
  it { should respond_to(:height) }
  it { should respond_to(:injury) }
  it { should respond_to(:distance) }

  it { should respond_to(:ankle) }
  it { should respond_to(:knee) }
  it { should respond_to(:hip) }
  it { should respond_to(:functionality) }
  it { should respond_to(:total) }

  it { should respond_to :level }
  it { should respond_to :sport}
  it { should respond_to :distance }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe 'when email is not present' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end

  describe 'when email is already taken' do
    before do
      user_with_same_login = @user.dup
      user_with_same_login.email = @user.email.upcase
      user_with_same_login.save
    end

    it { should_not be_valid }
  end

  describe 'when password is not present' do
    before do
      @user = User.new(email: 'user@example.com',
                       password: ' ', password_confirmation: ' ')
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe 'return value of authenticate method' do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe 'with valid password' do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe 'with invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid') }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe 'remember token' do
    before { @user.save }
    it 'should have remember token' do
      expect(@user.remember_token).not_to be_blank
    end
  end
end
