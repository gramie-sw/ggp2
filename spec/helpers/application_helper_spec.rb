describe ApplicationHelper do

  describe '#main_navbar_link' do

    it 'should return active list item and link when main_navbar_link_active? returns true' do
      helper.should_receive(:main_navbar_link_active?).with(:active_key).and_return(true)
      helper.main_navbar_link('title', 'path', :active_key).should eq "<li class=\"active\">#{link_to('title', 'path')}</li>"
    end

    it 'should return non active list item and link when main_navbar_link_active? returns false' do
      helper.should_receive(:main_navbar_link_active?).with(:active_key).and_return(false)
      helper.main_navbar_link('title', 'path', :active_key).should eq "<li class=\"\">#{link_to('title', 'path')}</li>"
    end
  end

  describe '#main_navbar_link_active?' do

    context 'if aggregates controller is called' do
      before :each do
        helper.stub(:params).and_return(controller: 'aggregates')
      end

      it 'should return true if active key is aggregates' do
        helper.main_navbar_link_active?(:aggregates).should be_true
      end

      it 'should return false if active key is not aggregates' do
        helper.main_navbar_link_active?(:matches).should be_false
        helper.main_navbar_link_active?(:venues).should be_false
        helper.main_navbar_link_active?(:users).should be_false
      end
    end

    context 'if matches controller is called' do
      before :each do
        helper.stub(:params).and_return(controller: 'matches')
      end

      it 'should return true if active key is matches' do
        helper.main_navbar_link_active?(:matches).should be_true
      end

      it 'should return false if active key is not matches' do
        helper.main_navbar_link_active?(:aggregates).should be_false
        helper.main_navbar_link_active?(:venues).should be_false
        helper.main_navbar_link_active?(:users).should be_false
      end
    end

    context 'if venues controller is called' do
      before :each do
        helper.stub(:params).and_return(controller: 'venues')
      end

      it 'should return true if active key is venues' do
        helper.main_navbar_link_active?(:venues).should be_true
      end

      it 'should return false if active key is not venues' do
        helper.main_navbar_link_active?(:aggregates).should be_false
        helper.main_navbar_link_active?(:matches).should be_false
        helper.main_navbar_link_active?(:users).should be_false
      end
    end

    context 'if users controller is called' do
      before :each do
        helper.stub(:params).and_return(controller: 'users')
      end

      it 'should return true if active key is users' do
        helper.main_navbar_link_active?(:users).should be_true
      end

      it 'should return false if active key is not users' do
        helper.main_navbar_link_active?(:aggregates).should be_false
        helper.main_navbar_link_active?(:matches).should be_false
        helper.main_navbar_link_active?(:venues).should be_false
      end
    end
  end
end