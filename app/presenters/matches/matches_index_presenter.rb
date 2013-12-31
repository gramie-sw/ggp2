class MatchesIndexPresenter

  def initialize new_match=nil
    @new_match = new_match
  end

  def matches
    @matches ||= Match.all
  end

  def new_match
    @new_match ||= Match.new
  end
end