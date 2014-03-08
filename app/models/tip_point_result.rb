class TipPointResult

  include ActiveModel::Model
  extend RecordBatchUpdatable

  attr_accessor :match



  def save

  end






  private


  def match_tips
    @tips ||= Tip.match_tips match.id
  end

end