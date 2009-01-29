require 'bitfields'

describe BitFields do
  before do
    BitFields.template :test do | t |
      t.bits :start, :length => 3, :value => 0b111
      t.bits :middle, :length => 10, :value => 0
      t.bits :end, :length => 3, :value => 0
    end
  end

  it "should create the default test template correctly" do
    BitFields.create(:test).bit_string.should == "1110000000000000"
  end

  it "should create the test template correctly with parameters" do
    BitFields.create(:test, :end => 0b111).bit_string.should == "1110000000000111"
  end

  it "should create the test template correctly with parameters that do not exist in the template" do
    BitFields.create(:test, :bogus => 0b11111).bit_string.should == "1110000000000000"
  end

  it "should give you independent objects when created from the same template" do
    a = BitFields.create(:test, :middle => 0b1111111111)
    a.bit_string.should == "1111111111111000"
    b = BitFields.create(:test, :end => 0b111)
    b.bit_string.should == "1110000000000111"
    b[:end] = 0b101
    a[:end].bit_string.should == "000"
  end
end
