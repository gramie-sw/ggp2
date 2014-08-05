class TipFactory

  def initialize match_repository
    @match_repository= match_repository
  end

  def build_all
    match_repository.all.map do |match|
      Tip.new(match_id: match.id)
    end
  end

  private

  attr_reader :match_repository
end