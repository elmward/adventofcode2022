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

def main
  root = Node.new(DIR, '/', nil)
  pwd = root
  commands = File.readlines('./input.txt').map(&:strip).each do |line|
    if line.start_with?('$')
      cmd = line.split[1]
      if cmd == 'cd'
        name = line.split[2]
        if name == '..'
          pwd = pwd.parent
        elsif name == '/'
          pwd = root
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
      end
    else # ls output
      size, name = line.split
      if size == DIR.downcase
        pwd.children << Node.new(DIR, name, pwd)
      else
        pwd.children << Node.new(FILE, name, pwd, size.to_i)
      end
    end
  end
  puts gather_small_dirs(root).sum(&:size)
end

def gather_small_dirs(node)
  small_dirs = []
  small_dirs << node if node.type == DIR && node.size < 100_000
  small_dirs.concat(node.children.map { |n| gather_small_dirs(n) }).flatten
end

main if __FILE__ == $PROGRAM_NAME
