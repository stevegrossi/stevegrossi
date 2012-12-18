shared_examples_for 'a Postable' do
  context 'post navigation' do
    before :each do
      postable_symbol = class_to_symbol(published_postable.class)
      @first_postable = FactoryGirl.create(postable_symbol, published_at: 2.days.ago)
      @second_postable = FactoryGirl.create(postable_symbol, published_at: 1.day.ago)
    end
    describe '#previous' do
      it 'returns the previous published item of its class if present' do
        @second_postable.previous.should eq(@first_postable)
      end
    end
    describe '#next' do
      it 'returns the next published item of its class' do
        @first_postable.next.should eq(@second_postable)
      end
    end
  end
  describe '#draft?' do
    it 'knows if it is a draft' do
      published_postable.draft?.should eq(false)
      draft_postable.draft?.should eq(true)
    end
  end
  describe '#published?' do
    it 'knows if it is published' do
      published_postable.published?.should eq(true)
      draft_postable.published?.should eq(false)
    end
  end
  describe '#pretty_published_at' do
    it 'returns "Unpublished" if it is a draft' do
      draft_postable.pretty_published_at.should eq('Unpublished')
    end
    it 'returns its date as a pretty string if it is published' do
      expected = published_postable.published_at.strftime('%-m/%-e/%Y')
      published_postable.pretty_published_at.should eq(expected)
    end
  end
end
