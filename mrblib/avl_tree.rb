class AvlTree

  def initialize
    @root = Node::TERMINAL
  end

  attr_reader :root

  def left
    root.left
  end

  def right
    root.right
  end

  def insert(key, value)
    @root = root.insert(key, value)
  end
  alias :[]= :insert

  def delete(key)
    @root = root.delete(key) || root
  end

  def [](key)
    root[key]
  end

  class Node

    def initialize(key, value)
      @left = @right = TERMINAL
      @key = key
      @value = value
      @height = 1
    end

    attr_accessor :left
    attr_accessor :right
    attr_accessor :key
    attr_accessor :value

    def insert(key, value)
      case key <=> @key
      when 1
        @right = right.insert(key, value)
      when 0
        @value = value
      when -1
        @left = left.insert(key, value)
      end
      balance_tree
    end

    def delete(key)
      case key <=> @key
      when 1
        @right = right.delete(key)
        balance_tree
      when 0
        delete_node
      when -1
        @left = left.delete(key)
        balance_tree
      end
    end

    def [](key)
      case key <=> @key
      when -1
        left[key]
      when 0
        value
      when 1
        right[key]
      end
    end

    def balance_factor
      right.height - left.height
    end

    attr_accessor :height

    def balance_tree
      case balance_factor
      when 2
        if right.balance_factor == -1
          @right = right.rotate_right
        end
        rotate_left
      when -2
        if left.balance_factor == +1
          @left = left.rotate_left
        end
        rotate_right
      else
        recalculate_height
        self
      end
    end

    def rotate_left
      root = right
      @right = root.left
      root.left = self
      recalculate_height
      root.recalculate_height
      root
    end

    def rotate_right
      root = left
      @left = root.right
      root.right = self
      recalculate_height
      root.recalculate_height
      root
    end

    def recalculate_height
      # this is more 'readable' but slower than using a ternary expression
      # @height = [@left.height, @right.height].max + 1
      @height = (left.height > right.height ? left.height : right.height) + 1
    end

    def delete_node
      if height == 1
        TERMINAL
      elsif left.height >= 1 and right.height >= 1
        usurper
      else
        left.height >= 1 ? left : right
      end
    end

    def usurper
      node = balance_factor < 0 ? in_order_successor : in_order_predecessor
      node.right = right
      node.left = left
      node.balance_tree
    end

    def in_order_predecessor
      dynamic_usurper_search(:left)
    end

    def in_order_successor
      dynamic_usurper_search(:right)
    end

    def dynamic_usurper_search(direction = :left)
      opposite_direction = direction == :left ? :right : :left
      path = [current_node = self.send(direction)]
      while current_node.send(opposite_direction).height > 0 do
        current_node = current_node.send(opposite_direction)
        path << current_node
      end
      usurper = path.pop
      path.last.send((opposite_direction.to_s + '=').to_sym, Node::TERMINAL)
      path.reverse.each(&:balance_tree)
      usurper
    end

    class TerminalNode

      def initialize
        @key = @value = nil
        @height = 0
      end

      attr_reader :height

      def [](key)
        nil
      end

      def insert(key, value)
        Node.new(key, value)
      end
    end

    TERMINAL = TerminalNode.new
  end
end
