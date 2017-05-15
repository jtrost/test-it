require "ostruct"
require_relative "../lib/test_it"

TestIt.suite do
  # Test 1
  group("Basic syntax with to_be matcher") do
    expect(true.class.to_s).to_be(:equal, "TrueClass")
  end

  # Test 2
  group("Basic syntax with not_to_be matcher") do
    expect(true.class.to_s).not_to_be(:equal, "FalseClass")
  end

  # Test 3
  group("TestIt should allow setup") do
    before do
      @person = OpenStruct.new
      @person.name = "Jarred"
    end

    expect(@person.name).to_be(:equal, "Jarred")
  end

  # Test 4
  group("TestIt should allow stubbing") do
    before do
      @person = OpenStruct.new
      @person.name = "Jarred"
    end

    stub(@person) do
      @person.location = "Texas"
    end

    expect(@person.location).to_be(:equal, "Texas")
  end

  # Test 5
  group("TestIt should compare numbers") do
    expect(1).to_be(:greater_than,          0)
    expect(1).to_be(:greater_than_or_equal, 1)    
    expect(1).to_be(:less_than,             2)
    expect(1).to_be(:less_than_or_equal,    2)

    expect(1).not_to_be(:greater_than,          2)
    expect(1).not_to_be(:greater_than_or_equal, 2)
    expect(1).not_to_be(:less_than,             0)
    expect(1).not_to_be(:less_than_or_equal,    0)
  end

  # Test 6
  group("TestIt should keep count of the number of tests") do
    expect(TestIt.tests.count).to_be(:equal, 6)
  end
end
