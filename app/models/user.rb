class User < ActiveRecord::Base
  require 'roo'

  belongs_to :level
  belongs_to :sport

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create :parse_file
  has_secure_password

  default_scope -> { order 'report_date desc' }

  attr_accessor :file

  validates :file, presence: true, on: :create, unless:  Proc.new { |user| user.admin? }
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}, :if => :should_validate_password?

  scope :search, -> (term) { where('email like ?', "%#{term}%") }
  # scope :clients, -> (is_clients) { where('client = ?', is_clients)  }

  def updating_password?
    @updating_pwd || false
  end

  def updating_password=(value)
    @updating_pwd = value
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def should_validate_password?
    updating_password? || new_record?
  end

  def age
    if birthday.present?
      a = Date.today.year - birthday.year
      a -= 1 if Date.today < birthday + a.years
      a
    else
      ''
    end
  end

  def index_data
    json = {
        labels: %w(TOBILLO RODILLA CADERA FUNCIONALIDAD TOTAL),
        datasets: [
            {
                fillColor: 'rgba(220,220,220,0.5)',
                strokeColor: 'rgba(255,200,200,1)',
                pointColor: 'rgba(255,150,150,1)',
                pointStrokeColor: '#fff',
                data: [ankle, knee, hip, functionality, total]
            }
        ]
    }.to_json
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def parse_file
    spreadsheet = User::open_spreadsheet(file)
    puts "============== Last row:#{spreadsheet.last_row}"

    (2..spreadsheet.last_row-1).each do |i|
      row = spreadsheet.row(i)


      self.report_date = row[1] if row[0] == 'FECHA'
      first_name = row[1] if row[0] == 'NOMBRE'
      last_name = row[1] if row[0] == 'APELLIDOS'
      self.birthday = row[1] if row[0] == 'EDAD'

      # self.birthday = row[1] if row[0] == 'SEXO'
      self.weight = row[1] if row[0] == 'PESO'
      self.height = row[1] if row[0] == 'ALTURA'
      self.level_id = Level.find_or_create_by(name: row[1]).id if row[0] == 'NIVEL'
      self.sport_id = Sport.find_or_create_by(name: row[1]).id if row[0] == 'DEPORTE'


      self.injury = row[1] if row[0] == 'LESIÓN'

      self.ankle = (row[1]*100).to_i if row[0] == 'PERFORMANCE INDEX TOBILLO'
      self.knee = (row[1]*100).to_i if row[0] == 'PERFORMANCE INDEX RODILLA'
      self.hip = (row[1]*100).to_i if row[0] == 'PERFORMANCE INDEX CADERA'
      self.functionality = (row[1]*100).to_i if row[0] == 'PERFORMANCE INDEX FUNCIONALIDAD'
      self.total = (row[1]*100).to_i if row[0] == 'PERFORMANCE INDEX TOTAL'
    end

    # self.name = "#{first_name} #{last_name}".squish

  end

  def self.open_spreadsheet(file)
    Roo::Spreadsheet.open(file.path, extension: :xlsx)
    # case File.extname(file.original_filename)
    #   when '.csv' then Roo::CSV.new(file.path)
    #   when '.xls' then Roo::Excel.new(file.path)
    #   when '.xlsx' then Roo::Excelx.new(file.path)
    #   else raise "Unknown file type: #{file.original_filename}"
    # end
  end
end
