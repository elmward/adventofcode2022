# frozen_string_literal: true

FILE_TYPES = [DIR = 'DIR', FILE = 'FILE'].freeze

class Node
  attr_reader :name, :parent, :children, :type

  def initialize(type, name, parent, size = 0)
    @type = type
    @name = name
    @parent = parent
    @size = size
    @children = []
  end

  def size
    if type == FILE
      @size
    else
      children.sum(&:size)
    end
  end

  def inspect
    if type == DIR
      "#{name}: d #{children.inspect}"
    else
      "#{name}: f #{size}"
    end
  end
end

ROOT = Node.new(DIR, '/', nil)

def main
  pwd = ROOT
  File.readlines('./input.txt').map(&:strip).each do |line|
    if line.start_with?('$') && line.split[1] == 'cd'
      pwd = cd(pwd, line.split[2])
    else # ls output
      size, name = line.split
      size = size.to_i
      type = size.zero? ? DIR : FILE
      pwd.children << Node.new(type, name, pwd, size)
    end
  end
  puts gather_small_dirs(ROOT).sum(&:size)
end

def cd(pwd, name)
  case name
  when '..'
    pwd = pwd.parent
  when '/'
    pwd = ROOT
  else
    subdir = pwd.children.detect { |child| child.name == name }
    if subdir.nil?
      new_dir = Node.new(DIR, name, pwd)
      pwd.children << new_dir
      pwd = new_dir
    else
      pwd = subdir
    end
  end
  pwd
end

def gather_small_dirs(node)
  small_dirs = []
  small_dirs << node if node.type == DIR && node.size < 100_000
  small_dirs.concat(node.children.map { |n| gather_small_dirs(n) }).flatten
end

main if __FILE__ == $PROGRAM_NAME
