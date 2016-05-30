require 'station'

describe Station do
  subject { described_class.new("Southwark", 1) }

  it 'can be assigned a name' do
    expect(subject.name).to eq "Southwark"
  end

  it 'can be assigned a zone' do
    expect(subject.zone).to eq 1
  end
end
