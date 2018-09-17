#!/usr/bin/env ruby

require 'thor'

class GesturePasscode
  KEYS_HASH = {
    1 => [2, 4, 5],
    2 => [1, 3, 4, 5, 6],
    3 => [2, 5, 6],
    4 => [1, 2, 5, 7, 8],
    5 => [1, 2, 3, 4, 6, 7, 8, 9],
    6 => [2, 3, 5, 8, 9],
    7 => [4, 5, 8],
    8 => [4, 5, 6, 7, 9],
    9 => [5, 6, 8]
  }

  KEYS_ARRAY=[
    [[1,2],[1,4],[1,5]],
    [[2,1],[2,3],[2,4],[2,5],[2,6]],
    [[3,2],[3,5],[3,6]],
    [[4,1],[4,2],[4,5],[4,7],[4,8]],
    [[5,1],[5,2],[5,3],[5,4],[5,6],[5,7],[5,8],[5,9]],
    [[6,3],[6,5],[6,8],[6,9],[6,2]],
    [[7,4],[7,5],[7,8]],
    [[8,7],[8,9],[8,4],[8,5,],[8,6]],
    [[9,6],[9,5],[9,8]]
  ]

  def initialize(start_key, pass_length)
    @start_key = start_key
    @pass_length = pass_length
  end

  # TODO: SHOULD allow cross selected key, eg 2 -> 5 -> 8 -> 6 -> 4
  # TODO: does NOT work for length > 6
  def get_passcode_from_hsh
    result = [@start_key]

    while result.length < @pass_length
      key = KEYS_HASH[result[-1]].sample

      redo if result.include?(key)

      result << key
    end

    result
  end


  def get_passcode_from_ary
    result = [@start_key]

    while result.length < @pass_length
      key = KEYS_ARRAY[result[-1] - 1].sample[1]

      redo if result.include?(key)

      result << key
    end

    result
  end

  def print_result
    puts "Solution 1, use a hash of keys to define basic rules:"
    key_pass_hsh = get_passcode_from_hsh
    puts "printing sequence and keyboard..."
    puts key_pass_hsh.join " -> "
    print_3x3keyboard key_pass_hsh

    puts

    puts "Solution 2, use an array of keys to define basic rules:"
    key_pass_ary = get_passcode_from_ary
    puts "printing sequence and keyboard..."
    puts key_pass_ary.join " -> "
    print_3x3keyboard key_pass_ary
  end

  private def print_3x3keyboard(key_pass_array) # eg, [2, 5, 8, 9, 6, 3]
    # group array into a hash: { 2 => [..], 1 => [..], 0 => [..] }
    # representing 3 colums on the 3x3 keyboard
    grouped_keys = key_pass_array.sort.group_by { |n| n % 3 }

    (1..9).each_slice(3) do |keys|
      str = ''

      keys.each do |k|
        op = grouped_keys[k % 3]&.include?(k) ? "#{k} " : "* " # &. is same as .try
        str += op
      end

      puts str
    end
  end
end

class GesturePasscodeGenerator < Thor
  desc "get_passcode start_key pass_length", "Generate passcode w/ given starting key and length"
  def get_passcode(start_key, pass_length)
    GesturePasscode.new(start_key.to_i, pass_length.to_i).print_result
  end
end

GesturePasscodeGenerator.start(ARGV)

