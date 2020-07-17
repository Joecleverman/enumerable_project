require_relative 'spec_helper'
require_relative '../enumerable_methods.rb'

describe Enumerable do
  let(:arr) { [2, 3, 4] }
  let(:other_arr) { [1, 2, 2] }
  let(:empty) { [] }
  let(:hash) { {} }
  let(:element) { [1, 5, 2] }
  let(:value) { [1, 5, 8] }

  let(:value1) { [1, nil, 2] }
  let(:value2) { [1, false, 2] }
  let(:value3) { [1, 2, 4, 5] }
  let(:value4) { %w[dog dog dog dog] }
  let(:value5) { { a: 1, b: 2, c: 0 } }

  describe '#my_each' do
    it 'return enumerator if block not given' do
      expect(arr.my_each.class).to eq(Enumerator)
    end

    it 'loops an entire array' do
      other_arr.my_each { |n| empty[n] = n + 2 }
      expect(empty).to eq([nil, 3, 4])
    end

    it 'returns product of each item in array' do
      expect(arr.my_each { |i| i * 2 }).to eql([2, 3, 4])
    end
  end

  describe 'my_each_with_index' do
    it 'block not given' do
      expect(element.my_each_with_index.class).to eq(Enumerator)
    end

    it 'returns element without changes' do
      expect(other_arr.my_each_with_index { |n, _idx| n + 2 }).to eq([1, 2, 2])
    end

    it 'loops an entire array' do
      other_arr.my_each_with_index { |n, idx| empty[idx] = n + 2 }
      expect(empty).to eq([3, 4, 4])
    end

    it 'loops an entir hash' do
      value5.my_each_with_index { |(k, v), idx| hash[k] = v + idx }
      expect(hash).to eq(a: 1, b: 3, c: 2)
    end
  end

  describe 'my_select' do
    it 'return enumerator if no block not given' do
      expect(element.my_select.class).to eq(Enumerator)
    end
    it 'selects array' do
      expect(value3.my_select { |n| n > 3 }).to eq([4, 5])
    end
    it 'return array of symbols :foo from array' do
      expect(%i[foo bar foo].my_select { |x| x == :foo }).to eql(%i[foo foo])
    end
  end

  describe 'my_all?' do
    it 'block not given, none of the elements false or nil' do
      expect(element.my_all?).to eq(true)
    end
    it 'block not given, one of the elements false or nil' do
      expect(value1.my_all?).to eq(false)
    end
    it 'block not given, one of the elements false' do
      expect(value2.my_all?).to eq(false)
    end
    it 'block not given, one of the elements nil' do
      expect(value1.my_all?).to eq(false)
    end
    it 'pattern other than a Class or Regex' do
      expect(value4.my_all?('dog')).to eq(true)
    end
    it 'pattern other than a Class or Regex, false' do
      expect(%w[dog dog cat dog].my_all?('dog')).to eq(false)
    end
    it 'class given, all the elements from that class' do
      expect(value.my_all?(Integer)).to eq(true)
    end
    it 'class given, not all the elements from that class' do
      expect(value.my_all?(String)).to eq(false)
    end
    it 'all with array false' do
      expect(value3.my_all? { |n| n > 3 }).to eq(false)
    end
    it 'all with array true' do
      expect(value3.my_all? { |n| n >= 1 }).to eq(true)
    end
    it 'all with hash false' do
      expect(value5.my_all? { |_k, v| v == 2 }).to eq(false)
    end
    it 'all with hash true' do
      expect(value5.my_all? { |_k, v| v.is_a? Integer }).to eq(true)
    end
  end

  describe 'my_any?' do
    it 'block not given, any of the elements not false or nil' do
      expect([nil, false, nil, 1].my_any?).to eq(true)
    end

    it 'block not given, all of the elements false or nil' do
      expect([nil, false, nil].my_any?).to eq(false)
    end

    it 'pattern other than a Class or Regex' do
      expect(value4.my_any?('dog')).to eq(true)
    end

    it 'class given, any of the elements from that class' do
      expect([1, '5', 8].my_any?(Integer)).to eq(true)
    end

    it 'class given, none of the elements from that class' do
      expect(value.my_any?(String)).to eq(false)
    end

    it 'any with array true' do
      expect([1, 2, 4, 5].my_any? { |n| n > 3 }).to eq(true)
    end

    it 'any with array false' do
      expect([1, 2, 4, 5].my_any? { |n| n < 1 }).to eq(false)
    end

    it 'any with hash false' do
      expect(value5.my_any? { |_k, v| v > 20 }).to eq(false)
    end

    it 'any with hash true' do
      expect(value5.my_any? { |_k, v| v.is_a? Integer }).to eq(true)
    end
  end

  describe 'my_none?' do
    it 'a' do
      expect([nil].my_none?).to eq(true)
    end
    it 'b' do
      expect([nil, false, true].my_none?).to eq(false)
    end
    it 'pattern other than a Class or Regex' do
      expect(value4.my_none?('cat')).to eq(true)
    end
    it 'pattern other than a Class or Regex' do
      expect(value4.my_none?('dog')).to eq(false)
    end

    it 'Class, false' do
      expect(value4.my_none?(String)).to eq(false)
    end
    it 'Class, true' do
      expect(value4.my_none?(Integer)).to eq(true)
    end
    it 'none with array true' do
      expect(value4.none? { |word| word.length == 4 }).to eq(true)
    end
    it 'none with array false' do
      expect(%w[ant bear cat].none? { |word| word.length >= 4 }).to eq(false)
    end
    it 'none with hash true' do
      expect(value5.my_none? { |_k, v| v == 7 }).to eq(true)
    end
    it 'none with hash false' do
      expect(value5.my_none? { |_k, v| v.is_a? Integer }).to eq(false)
    end
  end

  describe 'my_count' do
    it 'block not given array' do
      expect(element.my_count).to eq(3)
    end
    it 'block not given hash' do
      expect({ a: 1, b: 2, c: 0, d: 5 }.my_count).to eq(4)
    end
    it 'counts array' do
      expect(element.my_count { |n| n > 4 }).to eq(1)
    end
    it 'counts hash' do
      expect({ a: 1, b: 2, c: 0, d: 5 }.my_count { |_k, v| v < 5 }).to eq(3)
    end
    it 'count with params' do
      expect(element.my_count(0)).to eq(0)
    end
    it 'count with params, equals' do
      expect(element.my_count(2)).to eq(1)
    end
  end

  describe 'my_map' do
    it 'block and proc not given' do
      expect(element.my_map.class).to eq(Enumerator)
    end

    it 'maps array with block' do
      expect(value3.my_map { |n| n + 2 }).to eq([3, 4, 6, 7])
    end

    it 'maps array with proc' do
      proc = proc { |n| n + 3 }
      expect(value3.my_map(proc)).to eq([4, 5, 7, 8])
    end

    it 'maps array with proc and block' do
      proc = proc { |n| n + 3 }
      expect(value3.my_map(proc) { |n| n + 2 }).to eq([4, 5, 7, 8])
    end

    it 'maps hash with block' do
      expect(value5.my_map { |k, v| k.to_s + v.to_s }).to eq(%w[a1 b2 c0])
    end

    it 'maps hash with proc' do
      proc = proc { |_k, v| v + 3 }
      expect(value5.my_map(proc)).to eq([4, 5, 3])
    end

    it 'maps hash with proc and block' do
      proc = proc { |_k, v| v + 3 }
      expect(value5.my_map(proc) { |_k, v| v + 2 }).to eq([4, 5, 3])
    end
  end

  describe '#my_inject' do
    describe 'when no block given and one parameter present' do
      it 'returns a combined value of the Range its called on specified by the operator symbol in parameter' do
        expect((5..10).my_inject(:+)).to eql(45)
      end

      it 'returns a combined value of the Array its called on specified by the operator symbol in parameter' do
        expect([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject(:+)).to eql(41)
      end
    end

    describe 'when no parameter present and block given' do
      it 'returns a combined value of the Array its called on specified by the block' do
        expect((5..10).my_inject { |sum, n| sum + n }).to eql(45)
      end

      it 'returns a combined value of the Array its called on specified by the block' do
        expect([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject { |sum, n| sum + n }).to eql(41)
      end
    end

    describe 'when two parameters present and no block given' do
      it 'returns a combined value of  1st param and Range specified by symbol in 2nd param' do
        expect((5..10).my_inject(1, :*)).to eql(151_200)
      end

      it 'returns a combined value of 1st param and Array specified by symbol in 2nd param' do
        expect([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject(1, :*)).to eql(170_100)
      end
    end

    describe 'when one parameter present and block given' do
      it 'returns a combined value of the Range specified by the block after combining the parameter to 1st element' do
        expect((5..10).my_inject(1) { |element, n| element * n }).to eql(151_200)
      end

      it 'returns a combined value of the Array specified by the block after combining the parameter to 1st element' do
        expect([2, 3, 5, 6, 1, 7, 5, 3, 9].my_inject(1) { |element, n| element * n }).to eql(170_100)
      end
    end
  end
end
