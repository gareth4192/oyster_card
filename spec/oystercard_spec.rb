require 'oystercard'

describe Oystercard do

    let(:station) {double(:station)}

    it 'can top up balance' do
        expect{ subject.top_up(1) }.to change{subject.balance}.by(1)
    end

    it 'raise error when max limit breached' do
        subject.top_up(subject.max_limit)
        expect{subject.top_up(1)}.
        to raise_error("Max limit exceeded #{subject.max_limit}")
    end

    it 'is in journey' do
        subject.top_up(10)
        subject.touch_in(:station)
        expect(subject.in_journey?).to eq true
    end

    it 'raises error for insufficient funds' do
        expect{subject.touch_in(:station)}.
        to raise_error("insufficient funds: #{subject.balance}")
    end

    it 'removes fare on touch out' do
        subject.top_up(10)
        expect {subject.touch_out}.to change{subject.balance}.
        by(-Oystercard::MIN_LIMIT)
    end

    #let(:this_station_dbl) {double(:this_station_dbl, touch_in_station: "kings cross" )}

    it 'stores station touched in at' do
        subject.top_up(10)
        subject.touch_in(:station)
        expect(subject.entry_station).to eq(:station)
    end



end
