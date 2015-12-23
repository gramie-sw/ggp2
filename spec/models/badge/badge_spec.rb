describe Badge do

  subject { Badge.new(color: 'platinum') }

  it { is_expected.to respond_to(:icon=, :icon) }
  it { is_expected.to respond_to(:achievement=, :achievement) }
  it { is_expected.to respond_to(:color=, :color) }
  it { is_expected.to respond_to(:score=, :score) }

  describe '#group_identifier' do

    context 'additional_elements is an array' do
      subject do
        class MyFancyBadge < Badge

          def group_identifier
            super(['add_element1', 'add_element2'])
          end
        end
        MyFancyBadge.new
      end

      it 'returns group_identifier' do
        expect(subject.group_identifier).to eq 'my_fancy_badge#add_element1#add_element2'
      end
    end

    context 'additional_elements is a string' do

      subject do
        class MyFancyBadge < Badge

          def group_identifier
            super('add_element1')
          end
        end
        MyFancyBadge.new
      end

      it 'returns group_identifier' do
        expect(subject.group_identifier).to eq 'my_fancy_badge#add_element1'
      end
    end

    context 'does not have additional_elements' do

      subject do
        class MyFancyBadge < Badge

          def group_identifier
            super
          end
        end
        MyFancyBadge.new
      end

      it 'returns group_identifier' do
        expect(subject.group_identifier).to eq 'my_fancy_badge'
      end
    end
  end

  describe '#identifier' do

    subject do
      class MyFancyBadge < Badge

        def group_identifier
          super(['element1', 'element2'])
        end
      end
      MyFancyBadge.new(color: 'green')
    end

    it 'returns identifier' do
      expect(subject.identifier).to eq 'my_fancy_badge#element1#element2#green'
    end
  end
end