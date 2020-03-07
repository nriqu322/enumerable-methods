#spec/enumerable.rb
require './enumerable.rb'

RSpec.describe Enumerable do
  let(:arr_1) { [2, 5, 1, 7, 4] }
  let(:arr_2) { [] }
  let(:arr_3) { [nil, true, 99] }
  let(:arr_4) { [nil, true, true] }
  let(:arr_5) { ['ant', 'bear', 'cat'] }

  describe "#my_each" do
    it 'go trough all elements in the object when block is given' do
      expect(arr_1.my_each{ |n| n }).to eql(arr_1)
    end

    it 'if no block is given return an enumerator' do
      expect(arr_1.my_each).to be_a(Enumerator)
    end

    it 'if an empty array is given' do
      expect(arr_2.my_each { |x| x }).to eql(arr_2)
    end
  end

  describe "#my_each_with_index" do
    it 'return array when block is given' do
      expect(arr_1.my_each_with_index { |value, idx| value }).to eql(arr_1)
    end

    it 'if no block is given return an enumerator' do
      expect(arr_1.my_each_with_index).to be_a(Enumerator)
    end
  end

  describe "#my_select" do
    it "return the elements that meet the given condition" do
      expect(arr_1.my_select { |x| x < 5}).to eql([2, 1, 4])
    end

  end

  describe "#my_all?" do
    it 'if all of the elements are integer return true' do
      expect(arr_1.my_all?(Integer)).to eql(true)
    end

    it 'if all the elements are true return true' do
      expect(arr_3.my_all? { |x| x == true}).to eql(false)
    end

    it 'if an empty string is passed return true' do
      expect(arr_2.my_all? { |x| x }).to eql(true)
    end
  end

  describe "#my_any?" do
    it 'return true if one of the elements meets the given condition' do
      expect(arr_5.my_any? { |w| w.length < 5 }).to eql(true)
    end

    it 'if an empty array is given return false' do
      expect(arr_2.my_any? { |x| x }).to eql(false)
    end

    it 'if not block is given return true unless an element is nil or false' do
      expect(arr_3.my_any?).to eql(true)
    end
  end

  describe "#my_none?" do
    it 'return true is none of the elements meets the given condition' do
      expect(arr_5.my_none? { |w| w.length == 5 }).to eql(true)
    end

    it 'if an empty array is given return true' do
      expect(arr_2.my_none? { |x| x }).to eql(true)
    end

    it 'if not block is given return true unles an element is true' do
      expect([nil, false].my_none?).to eql(true)
    end
  end

  describe "#my_count" do
    it 'if no block is given count all the elements of the input' do
      expect(arr_1.my_count).to eql(5)
    end

    it 'counts the elements that meets the condition given' do
      expect(arr_5.my_count { |x| x.length < 4 }).to eql(2)
    end
  end

  describe "#my_map" do
    it '' do
      expect(arr_2.mycount { |x| x }).to eql()
    end
  end

  describe "#my_inject" do
    it '' do
    end
  end
end
