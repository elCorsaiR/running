class User < ActiveRecord::Base
  require 'roo'

  belongs_to :level
  belongs_to :sport

  has_many :ankles, dependent: :delete_all
  has_many :foot_and_knee_angels, dependent: :delete_all

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create :parse_file
  has_secure_password

  scope :clients, -> { where admin: false }
  default_scope -> { order 'report_date desc' }

  attr_accessor :file

  validates :file, presence: true, on: :create, unless: Proc.new { |user| user.admin? }
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
        labels: %w(TOBILLO RODILLA FUNCIONALIDAD CADERA),
        datasets: [
            {
                label: "My First dataset",
                fillColor: "rgba(163,208,97,0.5)",
                strokeColor: "rgba(163,208,97,1)",
                pointColor: "rgba(163,208,97,1)",
                pointStrokeColor: "#fff",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: [ankle, knee, functionality, hip]
            }
        ]
    }.to_json
  end

  def bar_data
    json = {
        labels: ["Max...", "Veloci...", "Max..", "Veloci..."],
        datasets: [
            {
                label: "My First dataset",
                fillColor: "#958899",
                strokeColor: "#958899",
                highlightFill: "958899",
                highlightStroke: "958899",
                data: [max_pronation_left, pronation_speed_left, tibia_max_rotation_left, tibia_rotation_left]
            },
            {
                label: "My Second dataset",
                fillColor: "#fe8e64",
                strokeColor: "#fe8e64",
                highlightFill: "#fe8e64",
                highlightStroke: "#fe8e64",
                data: [max_pronation_right, pronation_speed_right, tibia_max_rotation_right, tibia_rotation_right]
            }
        ]
    }.to_json
    end

  def instant_of_max_pronation_data
    json = {
        labels: ["Instante Maxima..."],
        datasets: [
            {
                label: "My First dataset",
                fillColor: "#958899",
                strokeColor: "#958899",
                highlightFill: "958899",
                highlightStroke: "958899",
                data: [instant_of_left_max_pronation]
            },
            {
                label: "My Second dataset",
                fillColor: "#fe8e64",
                strokeColor: "#fe8e64",
                highlightFill: "#fe8e64",
                highlightStroke: "#fe8e64",
                data: [instant_of_right_max_pronation]
            }
        ]
    }.to_json
  end

  def perf_index_data
    json =
        [
            {
                value: 100 - total,
                color: "#ececec",
                highlight: "#ececec"
            },
            {
                value: total,
                color: "#a3d061",
                highlight: "#a3d061",
                label: "Performance index: "
            }

        ].to_json
  end

  def chart1_data
    [
        {
            value: left_stride_time_swing_per,
            color: "#b0a6b3",
            highlight: "#b0a6b3",
            label: "Vuelo"
        },
        {
            value: left_stride_time_stance_per,
            color: "#958899",
            highlight: "#958899",
            label: "Contacto"
        }

    ].to_json
  end

  def chart2_data
    [
        {
            value: right_stride_time_swing_per,
            color: "#ffab8b",
            highlight: "#ffab8b",
            label: "Vuelo"
        },
        {
            value: right_stride_time_stance_per,
            color: "#fe8e64",
            highlight: "#fe8e64",
            label: "Contacto"
        }

    ].to_json
  end

  def chart3_data
    [
        {
            value: right_stride_time_per,
            color: "#fe8e64",
            highlight: "#fe8e64",
            label: "DERECHA"
        },
        {
            value: left_stride_time_per,
            color: "#958899",
            highlight: "#958899",
            label: "IZQUIERDA"
        }

    ].to_json
  end

  def chart4_data
    [
        {
            value: right_stride_length_per,
            color: "#fe8e64",
            highlight: "#fe8e64",
            label: "DERECHA"
        },
        {
            value: left_stride_length_per,
            color: "#958899",
            highlight: "#958899",
            label: "IZQUIERDA"
        }

    ].to_json
  end

  def chart5_data
    [
        {
            value: right_stride_frequency_per,
            color: "#fe8e64",
            highlight: "#fe8e64",
            label: "DERECHA"
        },
        {
            value: left_stride_frequency_per,
            color: "#958899",
            highlight: "#958899",
            label: "IZQUIERDA"
        }

    ].to_json
  end

  def chart6_data

    json = {
        labels: ["Frecuencia de zancada", "Movimiento del talon", "Direccion punta del pie", "Anchura entre apoyo"],
        datasets: [
            {
                label: "My First dataset",
                fillColor: "#958899",
                strokeColor: "#958899",
                highlightFill: "958899",
                highlightStroke: "958899",
                data: [left_stride_frequency_evaluation, 0, tip_direction_of_left_foot_evaluation, width_between_left_stances_evaluation]
            },
            {
                label: "My Second dataset",
                fillColor: "#fe8e64",
                strokeColor: "#fe8e64",
                highlightFill: "#fe8e64",
                highlightStroke: "#fe8e64",
                data: [right_stride_frequency_evaluation, 0, tip_direction_of_right_foot_evaluation, width_between_right_stances_evaluation]
            }
        ]
    }.to_json
  end

  def foot_and_knee_data
    left_foot = foot_and_knee_angels.pluck :left_foot_angle
    left_knee = foot_and_knee_angels.pluck :left_knee_angle
    right_foot = foot_and_knee_angels.pluck :right_foot_angle
    right_knee = foot_and_knee_angels.pluck :right_knee_angle

    labels = ankles.map do |ankle|
      if (ankle.position % 20) == 0
        ankle.position
      else
        ''
      end
    end

    json = {
        labels: labels,
        datasets: [
            {
                label: "My First dataset",
                fillColor: "transparent",
                strokeColor: "#a196a4",
                pointColor: "#a196a4",
                pointStrokeColor: "#a196a4",
                pointHighlightFill: "#a196a4",
                pointHighlightStroke: "#a196a4",
                data: left_foot
            },
            {
                label: "My First dataset",
                fillColor: "transparent",
                strokeColor: "#a196a4",
                pointColor: "#a196a4",
                pointStrokeColor: "#a196a4",
                pointHighlightFill: "#a196a4",
                pointHighlightStroke: "#a196a4",
                data: left_knee
            },
            {
                label: "My First dataset",
                fillColor: "transparent",
                strokeColor: "#fe8e64",
                pointColor: "#fe8e64",
                pointStrokeColor: "#fe8e64",
                pointHighlightFill: "#fe8e64",
                pointHighlightStroke: "#fe8e64",
                data: right_foot
            },
            {
                label: "My First dataset",
                fillColor: "transparent",
                strokeColor: "#fe8e64",
                pointColor: "#fe8e64",
                pointStrokeColor: "#fe8e64",
                pointHighlightFill: "#fe8e64",
                pointHighlightStroke: "#fe8e64",
                data: right_knee
            }
        ]}.to_json

  end
def ankle_data
    left = ankles.pluck :left
    right = ankles.pluck :right
    labels = ankles.map do |ankle|
      if (ankle.position % 20) == 0
        ankle.position
      else
        ''
      end
    end

    json = {
        labels: labels,
        datasets: [
            {
                label: "Left",
                fillColor: "transparent",
                strokeColor: "#a196a4",
                pointColor: "#a196a4",
                pointStrokeColor: "#a196a4",
                pointHighlightFill: "#a196a4",
                pointHighlightStroke: "#a196a4",
                data: left
            },
            {
                label: "Right",
                fillColor: "transparent",
                strokeColor: "#fe8e64",
                pointColor: "#fe8e64",
                pointStrokeColor: "#fe8e64",
                pointHighlightFill: "#fe8e64",
                pointHighlightStroke: "#fe8e64",
                data: right
            }
        ]}.to_json

  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def parse_file
    if file.present?
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

        if row[0].to_s.start_with?('GRÁFICA ÁNGULO DEL PIE IZQUIERDO/DERECHO INSTANTE')
          self.ankles.build position: row[1].to_i, left: row[2], right: row[3]
        end

        self.max_pronation_left = row[1].to_i if row[0] == 'MÁXIMA PRONACIÓN IZQUIERDO'
        self.max_pronation_right = row[1].to_i if row[0] == 'MÁXIMA PRONACIÓN DERECHO'

        self.pronation_speed_left = row[1].to_i if row[0] == 'VELOCIDAD PRONACIÓN IZQUIERDO'
        self.pronation_speed_right = row[1].to_i if row[0] == 'VELOCIDAD PRONACIÓN DERECHO'

        self.tibia_max_rotation_left = row[1].to_i if row[0] == 'MÁXIMA ROTACIÓN TIBIAL IZQUIERDO'
        self.tibia_max_rotation_right = row[1].to_i if row[0] == 'MÁXIMA ROTACIÓN TIBIAL DERECHO'

        self.tibia_rotation_left = row[1].to_i if row[0] == 'VELOCIDAD ROTACIÓN TIBIAL IZQUIERDO'
        self.tibia_rotation_right = row[1].to_i if row[0] == 'VELOCIDAD ROTACIÓN TIBIAL DERECHO'

        self.left_stride_time = row[1] if row[0] == 'TIEMPO ZANCADA IZQUIERDA'
        self.left_stride_time_stance = row[1] if row[0] == 'TIEMPO APOYO IZQUIERDO'
        self.left_stride_time_stance_per = row[1].round if row[0] == 'TIEMPO APOYO IZQUIERDO %'
        self.left_stride_time_swing = row[1] if row[0] == 'TIEMPO VUELO IZQUIERDO'
        self.left_stride_time_swing_per = row[1].round if row[0] == 'TIEMPO VUELO IZQUIERDO %'
        self.right_stride_time = row[1] if row[0] == 'TIEMPO ZANCADA DERECHA'
        self.right_stride_time_stance = row[1] if row[0] == 'TIEMPO APOYO DERECHA'
        self.right_stride_time_stance_per = row[1].round if row[0] == 'TIEMPO APOYO DERECHA %'
        self.right_stride_time_swing = row[1] if row[0] == 'TIEMPO VUELO DERECHA'
        self.right_stride_time_swing_per = row[1].round if row[0] == 'TIEMPO VUELO DERECHA %'
        self.stride_time = row[1] if row[0] == 'TIEMPO ZANCADA'
        self.left_stride_time_per = row[1].round if row[0] == 'TIEMPO ZANCADA IZQUIERDA %'
        self.right_stride_time_per = row[1].round if row[0] == 'TIEMPO ZANCADA DERECHA %'
        self.stride_length = row[1] if row[0] == 'LONGITUD ZANCADA'
        self.left_stride_length = row[1] if row[0] == 'LONGITUD ZANCADA IZQUIERDA'
        self.left_stride_length_per = row[1].round if row[0] == 'LONGITUD ZANCADA IZQUIERDA %'
        self.right_stride_length = row[1] if row[0] == 'LONGITUD ZANCADA DERECHA'
        self.right_stride_length_per = row[1].round if row[0] == 'LONGITUD ZANCADA DERECHA %'

        self.stride_frequency = row[1].round if row[0] == 'FRECUENCIA ZANCADA'
        self.left_stride_frequency = row[1].round if row[0] == 'FRECUENCIA ZANCADA IZQUIERDA'
        self.left_stride_frequency_per = row[1].round if row[0] == 'FRECUENCIA ZANCADA IZQUIERDA %'
        self.right_stride_frequency = row[1].round if row[0] == 'FRECUENCIA ZANCADA DERECHA'
        self.right_stride_frequency_per = row[1].round if row[0] == 'FRECUENCIA ZANCADA DERECHA %'
        self.left_stride_frequency_evaluation = row[1] if row[0] == 'EVALUACIÓN FRECUENCIA ZANCADA IZQUIERDA'
        self.right_stride_frequency_evaluation = row[1] if row[0] == 'EVALUACIÓN FRECUENCIA ZANCADA DERECHA'
        self.width_between_left_stances_evaluation = row[1] if row[0] == 'EVALUACIÓN ANCHURA ENTRE APOYO IZQUIERDA'
        self.width_between_right_stances_evaluation = row[1] if row[0] == 'EVALUACIÓN ANCHURA ENTRE APOYO DERECHA'
        self.tip_direction_of_left_foot_evaluation = row[1] if row[0] == 'EVALUACIÓN DIRECCIÓN PUNTA DEL PIE IZQUIERDO'
        self.tip_direction_of_right_foot_evaluation = row[1] if row[0] == 'EVALUACIÓN DIRECCIÓN PUNTA DEL PIE DERECHO'

        if row[0].to_s.start_with?('GRÁFICA ÁNGULO DEL PIE Y ÁNGULO SAGITAL DE LA RODILLA IZQUIERDO/DERECHO INSTANTE')
          self.foot_and_knee_angels.build position: row[1].to_i, left_foot_angle: row[2], left_knee_angle: row[3], right_foot_angle: row[4], right_knee_angle: row[5]
        end

        self.instant_of_left_max_pronation = row[1] if row[0] == 'INSTANTE MÁXIMA PRONACIÓN IZQUIERDA'
        self.instant_of_right_max_pronation = row[1] if row[0] == 'INSTANTE MÁXIMA PRONACIÓN DERECHA'
      end

      # self.name = "#{first_name} #{last_name}".squish
    end

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
