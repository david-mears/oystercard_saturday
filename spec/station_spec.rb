require 'station'

describe Station do

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :zone }

  subject {described_class.new("Old Street", 1)}

  it 'knows its name' do
    expect(subject.name).to eq("Old Street")
  end

  it 'knows its zone' do
    expect(subject.zone).to eq(1)
  end

end
