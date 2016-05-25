class User

  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Custom fields
  field :name,               type: String
  field :admin,              type: Boolean
  # Count of services that user bought
  field :services, type: Hash, default: { "Check request" => 0, "Search request" => 0 }

  embeds_many :reviews

  field :reports_ids, type: Array
  def after_database_authentication
    ago = Time.now - 5.minutes
    #self.update_attribute(:name, "Adminaa")

  
    

    if ago > self.last_sign_in_at
      UserMailer.welcome_email(self.email,self.last_sign_in_at).deliver_now
    end
    #kovalenlosha@gmail.com
  end

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
 # адміністратор, для введення послуги вікно, як вводити послуги, третій рівень для 3-тьої лаби
end


#1,9,2
