# frozen_string_literal: true

FILE_TYPES = [DIR = 'DIR', FILE = 'FILE'].freeze
FILESYSTEM_SIZE = 70_000_000
TOTAL_SPACE_NEEDED = 30_000_000

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
      children.map { |c| c.size }.sum
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
  commands = File.readlines('./input.txt').map(&:strip)
  commands.each do |command|
    if command.start_with?('$')
      cmd = command.split[1]
      if cmd == 'cd'
        name = command.split[2]
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
      size, name = command.split
      if size == DIR.downcase
        pwd.children << Node.new(DIR, name, pwd)
      else
        pwd.children << Node.new(FILE, name, pwd, size.to_i)
      end
    end
  end
  needed_space = TOTAL_SPACE_NEEDED - (FILESYSTEM_SIZE - root.size)
  smallest_adequate_dir = gather_big_dirs(root, needed_space).min_by(&:size)
  puts smallest_adequate_dir.size
end

def gather_big_dirs(node, needed_space)
  big_dirs = []
  if node.type == DIR && node.size >= needed_space
    big_dirs << node
  end
  big_dirs.concat(node.children.map { |n| gather_big_dirs(n, needed_space) }).flatten
end

main if __FILE__ == $PROGRAM_NAME
