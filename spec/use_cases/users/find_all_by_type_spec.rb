describe 'Users::FindAllByType' do

  subject { Users::FindAllByType }

  describe '#run' do

    type = User::TYPES[:admin]
    page = 3
    per_page = 16

    before :each do
      allow(Ggp2.config).to receive(:user_page_count).and_return(per_page)
    end

    it 'returns all users paginated by given type ordered by nickname' do
      expect(UserQueries).to respond_to(:all_by_type_ordered)
      expect(UserQueries).to receive(:all_by_type_ordered).with(
                                 type: type,
                                 order: :nickname,
                                 page: page,
                                 per_page: per_page
                             ).and_return(:users)

      subject.run(type: type, page: page)
    end

    describe 'if no type given' do

      it 'it uses type players' do
        expect(UserQueries).to respond_to(:all_by_type_ordered)
        expect(UserQueries).to receive(:all_by_type_ordered).with(
                                   type: User::TYPES[:player],
                                   order: :nickname,
                                   page: page,
                                   per_page: per_page
                               ).and_return(:users)

        subject.run(page: page)
      end
    end
  end

end