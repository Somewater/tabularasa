class Section < ActiveRecord::Base
  attr_accessible :name, :title, :weight, :visible

  MAIN_NAME = 'main'

  def self.main
    self.find_by_name(MAIN_NAME)
  end

  def main?
    self.name == MAIN_NAME
  end

  def to_param
    self.name
  end
end
