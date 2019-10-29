require 'pry'

puts 'START'

class Array

  def my_each(&block)
    self.length.times do |i|
      block.call(self[i])
    end

    self
  end

  def my_select(&block)
      arr = []

      self.my_each { |ele| arr << ele if block.call(ele) }

      arr
  end

  def my_reject(&block)
      arr = []

      self.my_each { |ele| arr << ele unless block.call(ele) }

      arr
  end

  def my_any?(&block)
      self.my_each { |ele| return true if block.call(ele) }

      false
  end

  def my_all?(&block)
      self.my_each { |ele| return false unless block.call(ele) }

      true
  end

  def my_flatten
    return self if !self.my_any? { |ele| ele.is_a?(Array) }

    arr = []

    self.my_each do |ele|
      arr << ele if ele.is_a?(Integer)
      ele.my_each { |ele2| arr << ele2 } if ele.is_a?(Array)
    end

    arr = arr.my_flatten
  end

  def my_zip(*arg)
    arr = []
    arr_arg = []
    arr_method = self

    i = 0
    while i < arg.length
      arr_arg << arg[i]
      i += 1
    end

    arr_method.each_with_index do |ele, idx1|
      arr2 = []
      arr2 << ele
      arr_arg.each_with_index do |ele, idx2|
        arr2 << ele[idx1]
      end
      arr << arr2
    end

    arr
  end

  def my_rotate(position = 1)
    arr = []
    num = position.abs

    num.times do
      if position < 0
        removed = self.pop
        arr = self
        arr.unshift(removed)
      else
        removed = self.shift
        arr = self
        arr.push(removed)
      end
    end

    arr
  end

  def my_join(arg = "")
    str = ""

    self.each_with_index do |ele, idx|
      if idx == self.length - 1
        str << ele
      else
        str << ele + arg
      end
    end

    str
  end

  def my_reverse
    arr = []

    self.length.times do
      arr << self.pop
    end

    arr
  end

end



binding.pry

puts 'END'
