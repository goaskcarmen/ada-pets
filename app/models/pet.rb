class Pet < ActiveRecord::Base

  validates :name, :human, :age, presence: true

  def as_json(options ={})
    options = options.merge only: [:id, :human, :age, :name]
    super(options)
  end
end
