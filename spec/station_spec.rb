require 'station'

describe Station do

  subject(:station){ described_class.new("Bank", 1) }
  let(:name) { double :name }

  it "has a name" do
    expect(station.name).to eq "Bank"
  end

  it "has a zone" do
    expect(station.zone).to be 1
  end

end