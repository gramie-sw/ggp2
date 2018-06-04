describe SiteNoticesController, :type => :controller do

  describe '#show' do

    it 'returns http success and render template show with site notice contact assigned' do

      expect(SiteNoticeQueries).to receive(:contact).and_return(:site_notice_contact)

      get :show
      expect(response).to be_success
      expect(response).to render_template :show
      expect(assigns(:contact)).to be :site_notice_contact
    end
  end
end