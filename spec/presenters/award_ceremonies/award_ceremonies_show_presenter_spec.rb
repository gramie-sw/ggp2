describe AwardCeremoniesShowPresenter do

  it 'should provide first_places accessors' do
    subject.should respond_to(:first_places)
    subject.should respond_to(:first_places=)
  end

  it 'should provide second_places accessors' do
    subject.should respond_to(:second_places)
    subject.should respond_to(:second_places=)
  end

  it 'should provide third_places accessors' do
    subject.should respond_to(:third_places)
    subject.should respond_to(:third_places=)
  end
end