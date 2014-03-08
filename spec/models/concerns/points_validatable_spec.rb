describe PointsValidatable do

  class ModelWithPoints
    include ActiveModel::Model
    include PointsValidatable

    attr_accessor :points

    alias :points? :points
  end

  subject { ModelWithPoints.new}

  describe 'for points' do
    it { should allow_value(nil).for(:points) }
    it { should validate_numericality_of(:points).only_integer}
    it { should validate_numericality_of(:points).is_greater_than_or_equal_to 0 }
    it { should validate_numericality_of(:points).is_less_than_or_equal_to 1000 }
  end
end