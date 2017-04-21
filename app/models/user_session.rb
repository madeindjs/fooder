class UserSession < Authlogic::Session::Base
  attr_accessor :login

  validate :must_be_activated

  private

  def must_be_activated
    if attempted_record and !attempted_record.activated
      errors.add(:activation, 'You have not yet activated your account.')
    end
  end
end