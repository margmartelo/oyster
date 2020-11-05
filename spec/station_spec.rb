require 'station'

describe Station do
  subject {Station.new('Liverpool Street', 1)}
  it "initializes with a name" do
    expect(subject.name).to eq("Liverpool Street")
  end

  it "initializes with a zone" do
    expect(subject.zone).to eq(1)
  end
end
