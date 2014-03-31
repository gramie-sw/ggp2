describe UserCreateService do

  let(:match_repository) { Match }
  let(:tip_factory) { TipFactory }

  let(:user_attributes) do
    {
        nickname: 'Player',
        first_name: 'Hans',
        last_name: 'Mustermann',
        email: 'hans.mustermann@mail.com',
        password: '12345678',
        password_confirmation: '12345678',
        admin: false
    }
  end

  let(:tips) do

    [
        Tip.new(match_id: 12),
        Tip.new(match_id: 13)
    ]
  end

  let(:user) { double 'user' }

  subject { UserCreateService.new match_repository: match_repository, tip_factory: tip_factory }

  describe '#create_tips_for_user' do

    it 'should create and save user with given attributes and created tips' do
      User.should_receive(:new).with(user_attributes).and_return(user)
      tip_factory.should_receive(:build_all).and_return(tips)
      user.should_receive(:tips=).with(tips)
      user.should_receive(:save)
      subject.create user_attributes
    end

    context 'on success' do

      before :each do
        User.stub(:new).and.return
        User.any_instance.stub(:save).and_return(user)
      end

      #it '#should return Result with successful is true' do
      #  tip_factory.stub(:build_all).and_return(tips)
      #  result = subject.create user_attributes
      #
      #  result.user.should eq user
      #  result.successful?.should be_true
      #
      #
      #
      #end
    end

    context 'on failure' do

      before :each do
        User.any_instance.stub(:save).and_return false
      end

      it'#should return Result with successful is false' do

      end
    end
  end
end