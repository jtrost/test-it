# About
TestIt demonstrates how a testing framework can be quickly scaffolded using Ruby 2. Specifically, it demonstrates:

* Call test code with BasicObject#instance_eval
* Stub objects with Module#prepend
* Match expected and computed values with BasicObject#__send__

This isn't meant to be a full-featured testing framework, so please don't use it to test production code.

# Tests
TestIt uses its own DSL to document and test itself. Run tests with: `ruby test/test_it_test.rb`
