class SingleTest
  attr_accessor :computed, # The value returned by calling the method on the object
                :expected, # The value that user wants the method to return
                :operator, # How to compare the computed and expected values
                :status    # Did this test succeed or fail?

  OPERATORS = {
    equal:                 { to_be: :==, not_to_be: :!= },
    greater_than:          { to_be: :>,  not_to_be: :<  },
    greater_than_or_equal: { to_be: :>=, not_to_be: :<= },
    less_than:             { to_be: :<,  not_to_be: :>  },
    less_than_or_equal:    { to_be: :<=, not_to_be: :>= }
  }

  MATCHERS = [:to_be, :not_to_be]

  def before(&block)
    yield if block_given?
  end

  def expect(*args)
    self.computed = args[0]
    self
  end

  def stub(object, &block)
    if block_given?
      mod = Module.new{yield}
      object.class.prepend mod
    end
  end

  MATCHERS.each do |matcher|
    define_method(matcher) do |*args|
      self.operator = args[0]
      self.expected = args[1]
      run(matcher)
    end
  end

  def run(matcher)
    test_strategy = OPERATORS[self.operator]
    print_result(self.computed.__send__(test_strategy[matcher], self.expected))
  end

  private

  def print_result(result)
    if result == true
      self.status = :success
      puts "Passed"
    else
      self.status = :failure
      puts <<-MESSAGE
Expected: #{self.expected}
Received: #{self.computed}
Using:    #{operator.to_s}\n
MESSAGE
    end
  end
end
