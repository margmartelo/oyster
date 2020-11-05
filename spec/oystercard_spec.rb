require 'oystercard'

describe Oystercard do
  let(:station) { double :station}

  context '#balance' do
    it 'when created has a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  context '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance of the card' do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5)
    end
  end

  context '#max limit' do
    it 'raises error :you have exceeded your max balance if over limit' do
      limit = Oystercard::LIMIT
      subject.top_up(limit)
      expect { subject.top_up(1) }.to raise_error "you have exeeded your max balance of #{limit}"
    end
  end

  # context '#Deduct Money' do
  #   it { is_expected.to respond_to(:deduct).with(1).argument }
  #
  #   it 'can deduct money from the balance of the card' do
  #     expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
  #   end
  # end

  context '#Journey status' do
    it 'user will initlialize "not in journey"' do
      expect(subject).not_to be_in_journey
    end
  end
  context '#Touching in/out' do
    it { is_expected.to respond_to :touch_in }

    it 'touching in will change status of in_journey to true' do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'will raise an error if user touches in without money in balance' do
      expect { subject.touch_in(station) }.to raise_error "not enough balance"
    end

    it "will storage station when touch_in" do
      subject.top_up(20)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it 'touching out in will change status of in_journey to false' do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'will charge minimum fare deducting it from balance' do
      subject.top_up(5)
      subject.touch_in(station)
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MIN_FARE)
    end

    # it 'will raise an error if user touches out whilst not in journey' do
    #   expect { subject.touch_out }.to raise_error 'not in journey'
    # end
  end
end
