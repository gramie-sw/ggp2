describe ApplicationController do

  describe '#random_quotation' do

    it 'returns random quotation' do
      quotation = Quotation.new
      expect(QuotationQueries).to respond_to(:find_sample)
      expect(QuotationQueries).to receive(:find_sample).and_return(quotation)

      expect(subject.random_quotation).to be quotation
    end
  end

  describe '#main_navbar_presenter' do

    let(:params) { {controller: 'users'} }

    before :each do
      allow(subject).to receive(:current_user).and_return(current_user)
      allow(subject).to receive(:params).and_return(params)
      allow(subject).to receive(:tournament).and_return(Tournament.new)
    end

    context 'if current_user is admin' do

      let(:current_user) { User.new(admin: true) }

      it 'returns AdminMainNavPresenter' do
        presenter = subject.main_navbar_presenter
        expect(presenter).to be_an_instance_of AdminMainNavbarPresenter
        expect(presenter.params).to be params
      end
    end

    context 'if current_user is no admin' do

      let(:current_user) { User.new(admin: false) }

      it 'returns UserMainNavPresenter' do
        presenter = subject.main_navbar_presenter
        expect(presenter).to be_an_instance_of UserMainNavbarPresenter
        expect(presenter.params).to be params
      end
    end
  end
end