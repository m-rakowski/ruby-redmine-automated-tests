class User
  attr_accessor :login
  attr_accessor :password
  attr_accessor :firstname
  attr_accessor :lastname
  attr_accessor :mail

  # Create the object
  def initialize(login, password, firstname, lastname, mail)
    @login = login
    @password = password
    @firstname = firstname
    @lastname = lastname
    @mail = mail
  end

  def self.generate_new
    time = Time.now.to_i.to_s
    return User.new('TestUser' + time,
                    'Password', 'John', 'Wick',
                    time + 'wigi@shayzam.net')
  end

end
