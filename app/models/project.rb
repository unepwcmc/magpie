class Project < ActiveRecord::Base
  attr_accessible :name

  validates :name, format: { with: /\A[a-z_]+\z/, message: "can only contain downcase letters and underscores (_)" }
  validate :name_cannot_start_with_pg_underscore

  after_create :prepare_project

  def use
    Apartment::Database.switch(name.downcase)
  end

  private

  def prepare_project
    Apartment::Database.create(name.downcase)
  end

  def name_cannot_start_with_pg_underscore
    if name.starts_with?('pg_')
      errors.add(:name, "can't start with 'pg_'")
    end
  end
end
