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
    return User.new('johnny' + time,
                             '1qazXSW@', 'John', 'Wick',
                             time + 'wigi@shayzam.net')

  end

  # # Say hi to everybody
  # def say_hi
  #   if @names.nil?
  #     puts "..."
  #   elsif @names.respond_to?("each")
  #     # @names is a list of some kind, iterate!
  #     @names.each do |name|
  #       puts "Hello #{name}!"
  #     end
  #   else
  #     puts "Hello #{@names}!"
  #   end
  # end
  #
  # # Say bye to everybody
  # def say_bye
  #   if @names.nil?
  #     puts "..."
  #   elsif @names.respond_to?("join")
  #     # Join the list elements with commas
  #     puts "Goodbye #{@names.join(", ")}.  Come back soon!"
  #   else
  #     puts "Goodbye #{@names}.  Come back soon!"
  #   end
  # end
end
