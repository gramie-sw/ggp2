describe ApplicationHelper, :type => :helper do

  describe '#main_navbar_link' do

    it 'should return active list item and link when main_navbar_link_active? returns true' do
      expect(helper).to receive(:main_navbar_link_active?).with(:active_key).and_return(true)
      expect(helper.main_navbar_link('title', 'path', :active_key)).to eq "<li class=\"active\">#{link_to('title', 'path')}</li>"
    end

    it 'should return non active list item and link when main_navbar_link_active? returns false' do
      expect(helper).to receive(:main_navbar_link_active?).with(:active_key).and_return(false)
      expect(helper.main_navbar_link('title', 'path', :active_key)).to eq "<li class=\"\">#{link_to('title', 'path')}</li>"
    end
  end

  describe '#main_navbar_link_active?' do

    context 'if aggregates controller is called' do
      before :each do
        allow(helper).to receive(:params).and_return(controller: 'aggregates')
      end

      it 'should return true if active key is aggregates' do
        expect(helper.main_navbar_link_active?(:aggregates)).to be_truthy
      end

      it 'should return false if active key is not aggregates' do
        expect(helper.main_navbar_link_active?(:matches)).to be_falsey
        expect(helper.main_navbar_link_active?(:venues)).to be_falsey
        expect(helper.main_navbar_link_active?(:users)).to be_falsey
      end
    end

    context 'if matches controller is called' do
      before :each do
        allow(helper).to receive(:params).and_return(controller: 'matches')
      end

      it 'should return true if active key is matches' do
        expect(helper.main_navbar_link_active?(:matches)).to be_truthy
      end

      it 'should return false if active key is not matches' do
        expect(helper.main_navbar_link_active?(:aggregates)).to be_falsey
        expect(helper.main_navbar_link_active?(:venues)).to be_falsey
        expect(helper.main_navbar_link_active?(:users)).to be_falsey
      end
    end

    context 'if venues controller is called' do
      before :each do
        allow(helper).to receive(:params).and_return(controller: 'venues')
      end

      it 'should return true if active key is venues' do
        expect(helper.main_navbar_link_active?(:venues)).to be_truthy
      end

      it 'should return false if active key is not venues' do
        expect(helper.main_navbar_link_active?(:aggregates)).to be_falsey
        expect(helper.main_navbar_link_active?(:matches)).to be_falsey
        expect(helper.main_navbar_link_active?(:users)).to be_falsey
      end
    end

    context 'if users controller is called' do
      before :each do
        allow(helper).to receive(:params).and_return(controller: 'users')
      end

      it 'should return true if active key is users' do
        expect(helper.main_navbar_link_active?(:users)).to be_truthy
      end

      it 'should return false if active key is not users' do
        expect(helper.main_navbar_link_active?(:aggregates)).to be_falsey
        expect(helper.main_navbar_link_active?(:matches)).to be_falsey
        expect(helper.main_navbar_link_active?(:venues)).to be_falsey
      end
    end
  end
end