describe NavLink do

  it { is_expected.to respond_to(:label, :label=) }
  it { is_expected.to respond_to(:url, :url=) }
  it { is_expected.to respond_to(:params, :params=) }
  it { is_expected.to respond_to(:is_active_for, :is_active_for=) }

  describe '#initialize' do

    it 'should provide mass_assignment' do
      subject = NavLink.new(label: 'label_1', url: 'url_1')
      expect(subject.label).to eq 'label_1'
    end
  end

  describe '#active?' do

    subject { NavLink.new(params: {controller: 'users', action: 'show', id: '7'}) }

    it 'returns true if params meets is_active_for requirements' do
      subject.is_active_for = {controller: :users}
      expect(subject.active?).to be true

      subject.is_active_for = {controller: :users, action: :show}
      expect(subject.active?).to be true

      subject.is_active_for = {controller: :users, action: :show, id: '7'}
      expect(subject.active?).to be true

      subject.is_active_for = {controller: 'users', action: 'show', id: '7'}
      expect(subject.active?).to be true

      subject.is_active_for = {controller: [:users, :settings]}
      expect(subject.active?).to be true

      subject.is_active_for = {controller: [:users, :settings], action: [:show, :edit]}
      expect(subject.active?).to be true
    end

    it 'returns false if params does not meet is_active_for requirements' do
      subject.is_active_for = {controller: :settings}
      expect(subject.active?).to be false

      subject.is_active_for = {controller: :users, action: :new}
      expect(subject.active?).to be false

      subject.is_active_for = {controller: :users, action: :show, id: '8'}
      expect(subject.active?).to be false

      subject.is_active_for = {controller: [:users, :settings], action: [:new, :edit]}
      expect(subject.active?).to be false
    end
  end
end
