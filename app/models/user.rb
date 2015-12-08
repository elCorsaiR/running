class User < ActiveRecord::Base
  require 'roo'

  belongs_to :level
  belongs_to :sport

  has_many :ankles, dependent: :delete_all
  has_many :foot_and_knee_angels, dependent: :delete_all
  has_many :knee_frontal_angles, dependent: :delete_all
  has_many :knee_rotations, dependent: :delete_all
  has_many :knee_sagital_angles, dependent: :delete_all
  has_many :hip_frontal_angles, dependent: :delete_all
  has_many :hip_rotations, dependent: :delete_all
  has_many :hip_sagital_angles, dependent: :delete_all
  has_many :session_videos, dependent: :delete_all
  has_many :program_videos, dependent: :delete_all
  has_many :programs, dependent: :delete_all
  has_many :recommendations, dependent: :delete_all

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  before_create :create_salt
  before_create :parse_file
  before_update :parse_file
  has_secure_password

  scope :clients, -> { where admin: false }
  default_scope -> { order 'report_date desc' }

  attr_accessor :file

  validates :file, presence: true, on: :create, unless: Proc.new { |user| user.admin? }
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}, :if => :should_validate_password?

  scope :search, -> (term) { where('email like ?', "%#{term}%") }
  # scope :clients, -> (is_clients) { where('client = ?', is_clients)  }

  def to_param
    "#{id}#{solt}"
  end

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
                label: 'My First dataset',
                fillColor: 'rgba(163,208,97,0.5)',
                strokeColor: 'rgba(163,208,97,1)',
                pointColor: 'rgba(163,208,97,1)',
                pointStrokeColor: '#fff',
                pointHighlightFill: '#fff',
                pointHighlightStroke: 'rgba(220,220,220,1)',
                data: [ankle, knee, functionality, hip]
            }
        ]
    }.to_json
  end

  def bar_data
    json = {
        labels: ['Max. pronación', 'Veloc. pronación', 'Max. rotación tibial', 'Veloc. rotación tibial'],
        datasets: [
            {
                label: 'izquierdo',
                fillColor: '#958899',
                strokeColor: '#958899',
                highlightFill: '#958899',
                highlightStroke: '#958899',
                data: [max_pronation_left, pronation_speed_left, tibia_max_rotation_left, tibia_rotation_left]
            },
            {
                label: 'derecho',
                fillColor: '#fe8e64',
                strokeColor: '#fe8e64',
                highlightFill: '#fe8e64',
                highlightStroke: '#fe8e64',
                data: [max_pronation_right, pronation_speed_right, tibia_max_rotation_right, tibia_rotation_right]
            }
        ]
    }.to_json
  end

  def instant_of_max_pronation_data
    json = {
        labels: ['Instante Max. pronación'],
        datasets: [
            {
                label: 'izquierdo',
                fillColor: '#958899',
                strokeColor: '#958899',
                highlightFill: '#958899',
                highlightStroke: '#958899',
                data: [instant_of_left_max_pronation]
            },
            {
                label: 'derecho',
                fillColor: '#fe8e64',
                strokeColor: '#fe8e64',
                highlightFill: '#fe8e64',
                highlightStroke: '#fe8e64',
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
                color: '#ececec',
                highlight: '#ececec'
            },
            {
                value: total,
                color: '#a3d061',
                highlight: '#a3d061',
                label: 'Performance index: '
            }

        ].to_json
  end

  def chart1_data
    [
        {
            value: left_stride_time_swing_per,
            color: '#b0a6b3',
            highlight: '#b0a6b3',
            label: 'Vuelo pie izq.'
        },
        {
            value: left_stride_time_stance_per,
            color: '#958899',
            highlight: '#958899',
            label: 'Contacto pie izq.'
        }

    ].to_json
  end

  def chart2_data
    [
        {
            value: right_stride_time_swing_per,
            color: '#ffab8b',
            highlight: '#ffab8b',
            label: 'Vuelo pie dcho.'
        },
        {
            value: right_stride_time_stance_per,
            color: '#fe8e64',
            highlight: '#fe8e64',
            label: 'Contacto pie dcho.'
        }

    ].to_json
  end

  def chart3_data
    [
        {
            value: right_stride_time_per,
            color: '#fe8e64',
            highlight: '#fe8e64',
            label: 'Zancada dcha.'
        },
        {
            value: left_stride_time_per,
            color: '#958899',
            highlight: '#958899',
            label: 'Zancada izq.'
        }

    ].to_json
  end

  def chart4_data
    [
        {
            value: right_stride_length_per,
            color: '#fe8e64',
            highlight: '#fe8e64',
            label: 'Zancada dcha.'
        },
        {
            value: left_stride_length_per,
            color: '#958899',
            highlight: '#958899',
            label: 'Zancada izq.'
        }

    ].to_json
  end

  def chart5_data
    [
        {
            value: right_stride_frequency_per,
            color: '#fe8e64',
            highlight: '#fe8e64',
            label: 'Pie dcho.'
        },
        {
            value: left_stride_frequency_per,
            color: '#958899',
            highlight: '#958899',
            label: 'Pie izq.'
        }

    ].to_json
  end

  def chart6_data

    json = {
        labels: ['Frecuencia de zancada', 'Direccion punta del pie', 'Anchura entre apoyo'],
        datasets: [
            {
                label: 'izquierdo',
                fillColor: '#958899',
                strokeColor: '#958899',
                highlightFill: '#958899',
                highlightStroke: '#958899',
                data: [left_stride_frequency_evaluation,  tip_direction_of_left_foot_evaluation, width_between_left_stances_evaluation]
            },
            {
                label: 'derecho',
                fillColor: '#fe8e64',
                strokeColor: '#fe8e64',
                highlightFill: '#fe8e64',
                highlightStroke: '#fe8e64',
                data: [right_stride_frequency_evaluation,  tip_direction_of_right_foot_evaluation, width_between_right_stances_evaluation]
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

    {
        labels: labels,
        datasets: [
            {
                label: 'Izquierdo',
                fillColor: 'transparent',
                strokeColor: '#a196a4',
                pointColor: '#a196a4',
                pointStrokeColor: '#a196a4',
                pointHighlightFill: '#a196a4',
                pointHighlightStroke: '#a196a4',
                data: left_foot
            },
            {
                label: 'Izquierdo',
                fillColor: 'transparent',
                strokeColor: '#a196a4',
                pointColor: '#a196a4',
                pointStrokeColor: '#a196a4',
                pointHighlightFill: '#a196a4',
                pointHighlightStroke: '#a196a4',
                data: left_knee
            },
            {
                label: 'Derecho',
                fillColor: 'transparent',
                strokeColor: '#fe8e64',
                pointColor: '#fe8e64',
                pointStrokeColor: '#fe8e64',
                pointHighlightFill: '#fe8e64',
                pointHighlightStroke: '#fe8e64',
                data: right_foot
            },
            {
                label: 'Derecho',
                fillColor: 'transparent',
                strokeColor: '#fe8e64',
                pointColor: '#fe8e64',
                pointStrokeColor: '#fe8e64',
                pointHighlightFill: '#fe8e64',
                pointHighlightStroke: '#fe8e64',
                data: right_knee
            }
        ]}.to_json

  end

  def knee_frontal_data
    left = knee_frontal_angles.pluck :left
    right = knee_frontal_angles.pluck :right
    labels = knee_frontal_angles.map do |ankle|
      if (ankle.position % 20) == 0
        ankle.position
      else
        ''
      end
    end

    {
        labels: labels,
        datasets: [
            {
                label: 'Izquierdo',
                fillColor: 'transparent',
                strokeColor: '#a196a4',
                pointColor: '#a196a4',
                pointStrokeColor: '#a196a4',
                pointHighlightFill: '#a196a4',
                pointHighlightStroke: '#a196a4',
                data: left
            },
            {
                label: 'Derecho',
                fillColor: 'transparent',
                strokeColor: '#fe8e64',
                pointColor: '#fe8e64',
                pointStrokeColor: '#fe8e64',
                pointHighlightFill: '#fe8e64',
                pointHighlightStroke: '#fe8e64',
                data: right
            }
        ]}.to_json

  end

  def abduction_data

    {
        labels: ['Abducción', 'Velocidad abducción'],
        datasets: [
            {
                label: 'izquierdo',
                fillColor: '#958899',
                strokeColor: '#958899',
                highlightFill: '#958899',
                highlightStroke: '#958899',
                data: [left_knee_abduction, right_knee_abduction]
            },
            {
                label: 'derecho',
                fillColor: '#fe8e64',
                strokeColor: '#fe8e64',
                highlightFill: '#fe8e64',
                highlightStroke: '#fe8e64',
                data: [left_knee_abduction_speed, right_knee_abduction_speed]
            }
        ]
    }.to_json
  end

  def knee_rotation_data
    left_right_data :knee_rotations
  end

  def knee_rotation_bar_data

    {
        labels: ['Rotación rodilla'],
        datasets: [
            {
                label: 'izquierdo',
                fillColor: '#958899',
                strokeColor: '#958899',
                highlightFill: '#958899',
                highlightStroke: '#958899',
                data: [left_knee_rotation]
            },
            {
                label: 'derecho',
                fillColor: '#fe8e64',
                strokeColor: '#fe8e64',
                highlightFill: '#fe8e64',
                highlightStroke: '#fe8e64',
                data: [right_knee_rotation]
            }
        ]
    }.to_json
  end

  def knee_sagital_data
    left_right_data :knee_sagital_angles
  end

  def flexion_data
    {
        labels: ['Flexión rodilla'],
        datasets: [
            {
                label: 'izquierdo',
                fillColor: '#958899',
                strokeColor: '#958899',
                highlightFill: '#958899',
                highlightStroke: '#958899',
                data: [left_knee_flexion]
            },
            {
                label: 'derecho',
                fillColor: '#fe8e64',
                strokeColor: '#fe8e64',
                highlightFill: '#fe8e64',
                highlightStroke: '#fe8e64',
                data: [right_knee_flexion]
            }
        ]
    }.to_json
  end

  def hip_frontal_data
    left_right_data :hip_frontal_angles
  end

  def hip_abduction_data
    {
        labels: ["Ángulo frontal de la cadera", "Aducción"],
        datasets: [
            {
                label: 'izquierdo',
                fillColor: '#958899',
                strokeColor: '#958899',
                highlightFill: '#958899',
                highlightStroke: '#958899',
                data: [left_hip_basculation, right_hip_basculation]
            },
            {
                label: 'derecho',
                fillColor: '#fe8e64',
                strokeColor: '#fe8e64',
                highlightFill: '#fe8e64',
                highlightStroke: '#fe8e64',
                data: [left_hip_abduction, right_hip_abduction]
            }
        ]
    }.to_json
  end

  def hip_rotations_data
    left_right_data :hip_rotations
  end

  def hip_rotation_bar_data

    {
        labels: ['Rotación interna de la cadera'],
        datasets: [
            {
                label: 'izquierdo',
                fillColor: '#958899',
                strokeColor: '#958899',
                highlightFill: '#958899',
                highlightStroke: '#958899',
                data: [left_hip_rotation]
            },
            {
                label: 'derecho',
                fillColor: '#fe8e64',
                strokeColor: '#fe8e64',
                highlightFill: '#fe8e64',
                highlightStroke: '#fe8e64',
                data: [right_hip_rotation]
            }
        ]
    }.to_json
  end

  def hip_sagital_data
    left_right_data :hip_sagital_angles
  end

  def hip_extension_data

    {
        labels: ['Máxima extensión cadera'],
        datasets: [
            {
                label: 'izquierdo',
                fillColor: '#958899',
                strokeColor: '#958899',
                highlightFill: '#958899',
                highlightStroke: '#958899',
                data: [left_hip_max_extension]
            },
            {
                label: 'derecho',
                fillColor: '#fe8e64',
                strokeColor: '#fe8e64',
                highlightFill: '#fe8e64',
                highlightStroke: '#fe8e64',
                data: [right_hip_max_extension]
            }
        ]
    }.to_json
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

    {
        labels: labels,
        datasets: [
            {
                label: 'Izquierdo',
                fillColor: 'transparent',
                strokeColor: '#a196a4',
                pointColor: '#a196a4',
                pointStrokeColor: '#a196a4',
                pointHighlightFill: '#a196a4',
                pointHighlightStroke: '#a196a4',
                data: left
            },
            {
                label: 'Derecho',
                fillColor: 'transparent',
                strokeColor: '#fe8e64',
                pointColor: '#fe8e64',
                pointStrokeColor: '#fe8e64',
                pointHighlightFill: '#fe8e64',
                pointHighlightStroke: '#fe8e64',
                data: right
            }
        ]}.to_json

  end

  def anatomica_data(field)
    #val = args[:left] ? q_angle_left : q_angle_right
    val = send(field).to_i
    color = color_by_field field
    [
        {
            value: 3 - val,
            color: '#ececec',
            highlight: '#ececec'
        },
        {
            value: val,
            color: color,
            highlight: color,
            label: mark(val)
        }
    ].to_json
  end

  def legs_length_discrepancy_data
    [{
         value: 3 - legs_length_discrepancy_left.to_i,
         color: '#ececec',
         highlight: '#ececec'
     },
     {
         value: legs_length_discrepancy_left.to_i,
         color: '#febc46',
         highlight: '#febc46',
         label: mark(legs_length_discrepancy_left.to_i)
     }].to_json
  end

  def back_foot_angle_data
    [
        {
            value: 3 - back_foot_angle_left.to_i,
            color: '#ececec',
            highlight: '#ececec'
        },
        {
            value: back_foot_angle_left.to_i,
            color: '#88768b',
            highlight: '#88768b',
            label: mark(back_foot_angle_left.to_i)
        }
    ].to_json
  end

  def hip_rotatoes_data
    [
        {
            value: 3 - hip_rotatoes_left.to_i,
            color: '#ececec',
            highlight: '#ececec'
        },
        {
            value: hip_rotatoes_left.to_i,
            color: '#fa874e',
            highlight: '#fa874e',
            label: mark(hip_rotatoes_left.to_i)
        }
    ].to_json
  end

  def a1_data
    [
            {
                value: ((q_angle_left.to_i + q_angle_right.to_i) / 2).to_i,
                color:"#fa874e",
                highlight: "#fa874e",
                label: "Angulo Q"
            },
            {
                value: (legs_length_discrepancy_left.to_i + legs_length_discrepancy_right.to_i) / 2,
                color: "#febc46",
                highlight: "#febc46",
                label: "Discrepancia"
            },
            {
                value: (back_foot_angle_left.to_i + back_foot_angle_right.to_i) / 2,
                color: "#ffcb8c",
                highlight: "#ffcb8c",
                label: "Angulo del retro-pie"
            }

        ].to_json
  end

  def a2_data
    [
        {
            value: ((hip_rotatoes_left.to_i + hip_rotatoes_right.to_i) / 2).to_i,
            color:"#fa874e",
            highlight: "#fa874e",
            label: "Rotadores de cadero"
        },
        {
            value: (isquiotibiales_left.to_i + isquiotibiales_right.to_i) / 2,
            color: "#febc46",
            highlight: "#febc46",
            label: "Isquitibiles"
        },
        {
            value: (iliotibial_band_left.to_i + iliotibial_band_right.to_i) / 2,
            color: "#ffcb8c",
            highlight: "#ffcb8c",
            label: "Recto femoral"
        },
        {
            value: (psoas_iliaco_left.to_i + psoas_iliaco_right.to_i) / 2,
            color: "#cbcad4",
            highlight: "#cbcad4",
            label: "Psoas iliaco"
        },
        {
            value: (recto_femoral_left.to_i + recto_femoral_right.to_i) / 2,
            color: "#88768b",
            highlight: "#88768b",
            label: "Recto femoral"
        },
        {
            value: (gastrocnemius_y_soleo_left.to_i + gastrocnemius_y_soleo_right.to_i) / 2,
            color: "#6483c3",
            highlight: "#6483c3",
            label: "Gastrocnemius y soleo"
        }

    ].to_json
  end

  def a3_data
    [
        {
            value: ((mid_gluteus_strength_left.to_i + mid_gluteus_strength_right.to_i) / 2).to_i,
            color:"#fa874e",
            highlight: "#fa874e",
            label: "Gluteo medio"
        },
        {
            value: (isquiotibial_strength_left.to_i + isquiotibial_strength_right.to_i) / 2,
            color: "#febc46",
            highlight: "#febc46",
            label: "Isquiotibiles"
        },
        {
            value: (vasto_lateral_left.to_i + vasto_lateral_right.to_i) / 2,
            color: "#ffcb8c",
            highlight: "#ffcb8c",
            label: "Vasto lateral"
        },
        {
            value: (vasto_intermedio_left.to_i + vasto_intermedio_right.to_i) / 2,
            color: "#cbcad4",
            highlight: "#cbcad4",
            label: "Vasto intermedio"
        },
        {
            value: (vasto_medial_left.to_i + vasto_medial_right.to_i) / 2,
            color: "#88768b",
            highlight: "#88768b",
            label: "Vasto medial"
        },
        {
            value: (back_tibial_strength_left.to_i + back_tibial_strength_right.to_i) / 2,
            color: "#6483c3",
            highlight: "#6483c3",
            label: "Tibial posterior"
        }

    ].to_json
  end


  def self.find_by_idsolt(idsolt)
    length = idsolt.length
    id = idsolt[0..length - 6]
    solt = idsolt[length - 5..length-1]

    User.find_by(id: id, solt: solt) or raise ActiveRecord::RecordNotFound
  end

  private

  def mark(num)
    case num
      when 3 then
        'Óptimo'
      when 2 then
        'Aceptable'
      when 1 then
        'Bajo'
      else
        'Muy Bajo'
    end
  end

  def color_by_field(field)
    case  field
      when :q_angle_left, :q_angle_right, :hip_rotatoes_left, :hip_rotatoes_right, :mid_gluteus_strength_left, :mid_gluteus_strength_right
        '#fa874e'
      when :legs_length_discrepancy_left, :legs_length_discrepancy_right, :isquiotibiales_left, :isquiotibiales_right, :isquiotibial_strength_left, :isquiotibial_strength_right
          '#febc46'
      when :back_foot_angle_left, :back_foot_angle_right, :iliotibial_band_left, :iliotibial_band_right, :vasto_lateral_left, :vasto_lateral_right        
          '#ffcb8c'
      when :psoas_iliaco_left, :psoas_iliaco_right, :vasto_intermedio_left, :vasto_intermedio_right        
          '#cbcad4'
      when :recto_femoral_left, :recto_femoral_right, :vasto_medial_left, :vasto_medial_right 
          '#88768b'
      when :gastrocnemius_y_soleo_left, :gastrocnemius_y_soleo_right, :back_tibial_strength_left, :back_tibial_strength_right
          '#6483c3'        
      else
        '#ffffff'
    end
  end

  # def color_by_mark(num)
  #   case num
  #     when 3 then
  #       'Óptimo'
  #     when 2 then
  #       'Aceptable'
  #     when 1 then
  #       'Bajo'
  #     else
  #       'Muy Bajo'
  #   end
  # end

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def create_salt
    self.solt = rand.to_s[2..6]
  end

  def parse_file
    if file.present?
      clear_data

      spreadsheet = User::open_spreadsheet(file)
      puts "============== Last row:#{spreadsheet.last_row}"

      (2..spreadsheet.last_row).each do |i|
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

        if row[0].to_s.start_with?('GRÁFICA ÁNGULO FRONTAL DE LA RODILLA IZQUIERDO/DERECHO INSTANTE')
          self.knee_frontal_angles.build position: row[1].to_i, left: row[2], right: row[3]
        end

        self.left_knee_abduction = row[1] if row[0] == 'ABDUCCIÓN RODILLA IZQUIERDA'
        self.right_knee_abduction = row[1] if row[0] == 'ABDUCCIÓN RODILLA DERECHA'
        self.left_knee_abduction_speed = row[1] if row[0] == 'VELOCIDAD ABDUCCIÓN RODILLA IZQUIERDA'
        self.right_knee_abduction_speed = row[1] if row[0] == 'VELOCIDAD ABDUCCIÓN RODILLA DERECHA'

        if row[0].to_s.start_with?('GRÁFICA ROTACIÓNDE RODILLA IZQUIERDO/DERECHA INSTANTE')
          self.knee_rotations.build position: row[1].to_i, left: row[2], right: row[3]
        end

        self.left_knee_rotation = row[1] if row[0] == 'ROTACIÓN RODILLA IZQUIERDA'
        self.right_knee_rotation = row[1] if row[0] == 'ROTACIÓN RODILLA DERECHA'

        if row[0].to_s.start_with?('GRÁFICA ÁNGULO SAGITAL RODILLA IZQUIERDA/DERECHA INSTANTE')
          self.knee_sagital_angles.build position: row[1].to_i, left: row[2], right: row[3]
        end
        self.left_knee_flexion = row[1] if row[0] == 'FLEXIÓN RODILLA IZQUIERDA'
        self.right_knee_flexion = row[1] if row[0] == 'FLEXIÓN RODILLA DERECHA'

        if row[0].to_s.start_with?('GRÁFICA ÁNGULO FRONTAL CADERA IZQUIERDA/DERECHA INSTANTE')
          self.hip_frontal_angles.build position: row[1].to_i, left: row[2], right: row[3]
        end
        self.left_hip_abduction = row[1] if row[0] == 'ADUCCIÓN CADERA IZQUIERDA'
        self.right_hip_abduction = row[1] if row[0] == 'ADUCCIÓN CADERA DERECHA'
        self.left_hip_basculation = row[1] if row[0] == 'BASCULACIÓN CADERA IZQUIERDA'
        self.right_hip_basculation = row[1] if row[0] == 'BASCULACIÓN CADERA DERECHA'

        if row[0].to_s.start_with?('GRÁFICA ROTACIÓN CADERA IZQUIERDA/DERECHA INSTANTE')
          self.hip_rotations.build position: row[1].to_i, left: row[2], right: row[3]
        end
        self.left_hip_rotation = row[1] if row[0] == 'ROTACIÓN CADERA IZQUIERDA'
        self.right_hip_rotation = row[1] if row[0] == 'ROTACIÓN CADERA DERECHA'

        if row[0].to_s.start_with?('GRÁFICA ÁNGULO SAGITAL DE LA CADERA IZQUIERDA/DERECHA INSTANTE')
          self.hip_sagital_angles.build position: row[1].to_i, left: row[2], right: row[3]
        end
        self.left_hip_max_extension = row[1] if row[0] == 'MÁXIMA EXTENSIÓN CADERA IZQUIERDA'
        self.right_hip_max_extension = row[1] if row[0] == 'MÁXIMA EXTENSIÓN CADERA DERECHA'

        if row[0] == 'ANATÓMICOS ÁNGULO Q'
          self.q_angle_right = row[1]
          self.q_angle_left = row[2]
        end

        if row[0] == 'ANATÓMICOS DISCREPANCIA LONGITUD DE LAS PIERNAS'
          self.legs_length_discrepancy_right = row[1]
          self.legs_length_discrepancy_left = row[2]
        end
        if row[0] == 'ANATÓMICOS ÁNGULO DEL RETRO-PIE'
          self.back_foot_angle_right = row[1]
          self.back_foot_angle_left = row[2]
        end
        if row[0] == 'FUERZA TIBIAL POSTERIOR'
          self.back_tibial_strength_right = row[1]
          self.back_tibial_strength_left = row[2]
        end
        if row[0] == 'FUERZA GLÚTEO MEDIO'
          self.mid_gluteus_strength_right = row[1]
          self.mid_gluteus_strength_left = row[2]
        end
        if row[0] == 'FUERZA ISQUIOTIBIALES'
          self.isquiotibial_strength_right = row[1]
          self.isquiotibial_strength_left = row[2]
        end
        if row[0] == 'FUERZA VASTO INTERMEDIO'
          self.vasto_intermedio_right = row[1]
          self.vasto_intermedio_left = row[2]
        end
        if row[0] == 'FUERZA VASTO MEDIAL'
          self.vasto_medial_right = row[1]
          self.vasto_medial_left = row[2]
        end
        if row[0] == 'FUERZA VASTO LATERAL'
          self.vasto_lateral_right = row[1]
          self.vasto_lateral_left = row[2]
        end
        if row[0] == 'FLEXIBILIDAD PSOAS-ILIACO'
          self.psoas_iliaco_right = row[1]
          self.psoas_iliaco_left = row[2]
        end
        if row[0] == 'FLEXIBILIDAD RECTO FEMORAL'
          self.recto_femoral_right = row[1]
          self.recto_femoral_left = row[2]
        end
        if row[0] == 'FLEXIBILIDAD ISQUIOTIBIALES'
          self.isquiotibiales_right = row[1]
          self.isquiotibiales_left = row[2]
        end
        if row[0] == 'FLEXIBILIDAD BANDA ILIOTIBIAL'
          self.iliotibial_band_right = row[1]
          self.iliotibial_band_left = row[2]
        end
        if row[0] == 'FLEXIBILDIAD ROTADORES CADERA'
          self.hip_rotatoes_right = row[1]
          self.hip_rotatoes_left = row[2]
        end
        if row[0].to_s.include? 'FLEXIBILIDAD GASTROCNEMIUS Y SOLEO'
          self.gastrocnemius_y_soleo_right = row[1]
          self.gastrocnemius_y_soleo_left = row[2]
        end

        if (row[0].to_s.start_with?('URL VÍDEO REPRESENTACIÓN ESQUELÉTICA') or
           row[0].to_s.start_with?('URL VÍDEO VISIÓN LATERAL') or
           row[0].to_s.start_with?('URL VÍDEO VISION TRASERA') or
           row[0].to_s.start_with?('URL VIDEO PISTA DE ATLETISM')) and row[1].present?

          video_url = row[1]
          if video_url =~ /.*?vimeo.*?(\d+)/
            video_url = "https://player.vimeo.com/video/#{$1}"
          end
          self.session_videos.build video_url: video_url
        end

        if row[0].to_s.start_with?('EJERCICIO') and row[1].present?
          m = row[0].to_s.match(/\d+$/)
          num = nil
          num = row[0].to_s.match(/\d+$/)[0].to_i unless m.nil?
          if num.nil?
            self.programs.build text: row[1], order_num: num
          else
            found_programs = self.programs.select { |p| p.order_num == num }
            if found_programs.size > 0
              found_programs[0].text = row[1]
            else
              self.programs.build( order_num: num, text: row[1] )
            end
          end

        end

        if (row[0].to_s.start_with?('TITULO EJERCICIO') or row[0].to_s.start_with?('TÍTULO EJERCICIO')) and row[1].present?
          m = row[0].to_s.match(/\d+$/)
          num = nil
          num = row[0].to_s.match(/\d+$/)[0].to_i unless m.nil?
          unless num.nil?
            found_programs = self.programs.select { |p| p.order_num == num }
            if found_programs.size > 0
              found_programs[0].title = row[1]
            else
              self.programs.build( order_num: num, title: row[1] )
            end
          end
        end

        if row[0].to_s.start_with?('URL VIDEO EJERCICIO') and row[1].present?
          video_url = row[1]
          if video_url =~ /.*?vimeo.*?(\d+)/
            video_url = "https://player.vimeo.com/video/#{$1}"
          end

          self.program_videos.build video_url: video_url
        end

        if (row[0].to_s.start_with?('RECOMENDACION') or row[0].to_s.start_with?('RECOMENDACIÓN')) and row[1].present?
          m = row[0].to_s.match(/\d+$/)
          num = row[0].to_s.match(/\d+$/)[0].to_i unless m.nil?
          self.recommendations.build recommendation: row[1], order_no: num
        end

        self.conclusions = row[1] if row[0] == 'CONCLUSIONES'
      end

      # self.name = "#{first_name} #{last_name}".squish
    end

  end

  def clear_data
    self.report_date = nil
    first_name = nil
    last_name = nil
    self.birthday = nil

    # self.birthday = nil
    self.weight = nil
    self.height = nil
    self.level_id = nil
    self.sport_id = nil


    self.injury = nil

    self.ankle = nil
    self.knee = nil
    self.hip = nil
    self.functionality = nil
    self.total = nil

    self.ankles.delete_all

    self.max_pronation_left = nil
    self.max_pronation_right = nil

    self.pronation_speed_left = nil
    self.pronation_speed_right = nil

    self.tibia_max_rotation_left = nil
    self.tibia_max_rotation_right = nil

    self.tibia_rotation_left = nil
    self.tibia_rotation_right = nil

    self.left_stride_time = nil
    self.left_stride_time_stance = nil
    self.left_stride_time_stance_per = nil
    self.left_stride_time_swing = nil
    self.left_stride_time_swing_per = nil
    self.right_stride_time = nil
    self.right_stride_time_stance = nil
    self.right_stride_time_stance_per = nil
    self.right_stride_time_swing = nil
    self.right_stride_time_swing_per = nil
    self.stride_time = nil
    self.left_stride_time_per = nil
    self.right_stride_time_per = nil
    self.stride_length = nil
    self.left_stride_length = nil
    self.left_stride_length_per = nil
    self.right_stride_length = nil
    self.right_stride_length_per = nil

    self.stride_frequency = nil
    self.left_stride_frequency = nil
    self.left_stride_frequency_per = nil
    self.right_stride_frequency = nil
    self.right_stride_frequency_per = nil
    self.left_stride_frequency_evaluation = nil
    self.right_stride_frequency_evaluation = nil
    self.width_between_left_stances_evaluation = nil
    self.width_between_right_stances_evaluation = nil
    self.tip_direction_of_left_foot_evaluation = nil
    self.tip_direction_of_right_foot_evaluation = nil

    self.foot_and_knee_angels.delete_all

    self.instant_of_left_max_pronation = nil
    self.instant_of_right_max_pronation = nil

    self.knee_frontal_angles.delete_all

    self.left_knee_abduction = nil
    self.right_knee_abduction = nil
    self.left_knee_abduction_speed = nil
    self.right_knee_abduction_speed = nil

    self.knee_rotations.delete_all

    self.left_knee_rotation = nil
    self.right_knee_rotation = nil

    self.knee_sagital_angles.delete_all
    self.left_knee_flexion = nil
    self.right_knee_flexion = nil

    self.hip_frontal_angles.delete_all
    self.left_hip_abduction = nil
    self.right_hip_abduction = nil
    self.left_hip_basculation = nil
    self.right_hip_basculation = nil

    self.hip_rotations.delete_all
    self.left_hip_rotation = nil
    self.right_hip_rotation = nil

    self.hip_sagital_angles.delete_all
    self.left_hip_max_extension = nil
    self.right_hip_max_extension = nil

    self.q_angle_right = nil
    self.q_angle_left = nil

    self.legs_length_discrepancy_right = nil
    self.legs_length_discrepancy_left = nil
    self.back_foot_angle_right = nil
    self.back_foot_angle_left = nil
    self.back_tibial_strength_right = nil
    self.back_tibial_strength_left = nil
    self.mid_gluteus_strength_right = nil
    self.mid_gluteus_strength_left = nil
    self.isquiotibial_strength_right = nil
    self.isquiotibial_strength_left = nil
    self.vasto_intermedio_right = nil
    self.vasto_intermedio_left = nil
    self.vasto_medial_right = nil
    self.vasto_medial_left = nil
    self.vasto_lateral_right = nil
    self.vasto_lateral_left = nil
    self.psoas_iliaco_right = nil
    self.psoas_iliaco_left = nil
    self.recto_femoral_right = nil
    self.recto_femoral_left = nil
    self.isquiotibiales_right = nil
    self.isquiotibiales_left = nil
    self.iliotibial_band_right = nil
    self.iliotibial_band_left = nil
    self.hip_rotatoes_right = nil
    self.hip_rotatoes_left = nil
    self.gastrocnemius_y_soleo_right = nil
    self.gastrocnemius_y_soleo_left = nil

    self.session_videos.delete_all
    self.programs.delete_all
    self.program_videos.delete_all

    self.recommendations.delete_all
    self.conclusions = nil
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

  def left_right_data(table)
    left = self.send(table).pluck :left
    right = self.send(table).pluck :right
    labels = self.send(table).map do |ankle|
      if (ankle.position % 20) == 0
        ankle.position
      else
        ''
      end
    end

    {
        labels: labels,
        datasets: [
            {
                label: 'Izquierdo',
                fillColor: 'transparent',
                strokeColor: '#a196a4',
                pointColor: '#a196a4',
                pointStrokeColor: '#a196a4',
                pointHighlightFill: '#a196a4',
                pointHighlightStroke: '#a196a4',
                data: left
            },
            {
                label: 'Derecho',
                fillColor: 'transparent',
                strokeColor: '#fe8e64',
                pointColor: '#fe8e64',
                pointStrokeColor: '#fe8e64',
                pointHighlightFill: '#fe8e64',
                pointHighlightStroke: '#fe8e64',
                data: right
            }
        ]}.to_json
  end
end
