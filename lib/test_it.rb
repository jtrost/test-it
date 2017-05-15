require_relative "./single_test"

class TestIt
  @@tests = []

  def group(name, &block)
    puts "\n#{name}\n"

    single_test = SingleTest.new
    @@tests << single_test
    single_test.instance_eval(&block) 
  end

  class << self
    def suite(&block)
      @test = TestIt.new
      @test.instance_eval(&block)
      print_summary 
    end

    def tests
      @@tests
    end

    private

    def print_summary
      if tests.count > 0
        puts "#{tests.count} expectations with #{tests.select{|e| e.status == :success}.count} passing and #{tests.select{|e| e.status == :failure}.count} failing."
      else
        puts "No tests present"
      end
    end
  end
end
