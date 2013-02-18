shared_examples_for 'a Postable' do |postable_symbol|

  let!(:draft_postable) { FactoryGirl.create(postable_symbol, published_at: nil) }
  let!(:first_published_postable) { FactoryGirl.create(postable_symbol, published_at: 2.days.ago) }
  let!(:second_published_postable) { FactoryGirl.create(postable_symbol, published_at: 1.day.ago) }

  describe '#previous' do
    it 'returns the previous published item of its class' do
      second_published_postable.previous.should eq(first_published_postable)
    end
  end
  describe '#next' do
    it 'returns the next published item of its class' do
      first_published_postable.next.should eq(second_published_postable)
    end
  end
  describe '#draft?' do
    it 'knows if it is a draft' do
      draft_postable.draft?.should eq(true)
    end
  end
  describe '#published?' do
    it 'knows if it is published' do
      first_published_postable.published?.should eq(true)
    end
  end
  describe '#pretty_published_at' do
    it 'returns "Unpublished" if it is a draft' do
      draft_postable.pretty_published_at.should eq('Unpublished')
    end
    it 'returns its date as a pretty string if it is published' do
      expected = first_published_postable.published_at.strftime('%B %-e, %Y')
      first_published_postable.pretty_published_at.should eq(expected)
    end
  end
end
