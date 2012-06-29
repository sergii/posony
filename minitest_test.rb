require 'minitest/autorun'

class MinitestTest < MiniTest::Unit::TestCase
  def test_unit_class_is_loaded_in_autorun
    assert defined?(MiniTest::Unit)
  end

  def test_class_inherits_from_test_case
    assert_equal MiniTest::Unit::TestCase, self.class.superclass
  end

  def test_methods_start_with_test
    assert_includes self.class.test_methods, 'test_methods_start_with_test'
  end

  def test_assertions_fail_if_expression_is_false
    assert_raises MiniTest::Assertion do
      assert false
    end
  end

  def test_refutations_fail_if_expression_is_true
    assert_raises MiniTest::Assertion do
      refute true
    end
  end

  def test_assertions_pass_if_expression_is_true
    assert true
    assert_empty []
    assert_equal lambda { { :key => 'value' } }.call, -> { { key: 'value' } }.()
    #assert_in_delta
    #assert_in_epsilon
    #assert_includes
    #assert_instance_of
    #assert_kind_of
    #assert_match
    assert_nil nil
    #assert_operator
    #assert_output
    #assert_predicate
    assert_raises(NoMethodError) { self.y_so_serious? }
    #assert_respond_to
    #assert_same
    #assert_send
    #assert_silent
    #assert_throws
  end

  def test_refutations_pass_if_expression_is_false
    refute false
    refute_empty self.class.test_methods
    #refute_equal
    #refute_in_delta
    #refute_in_epsilon
    #refute_includes
    #refute_instance_of
    #refute_kind_of
    #refute_match
    #refute_nil
    #refute_operator
    #refute_predicate
    #refute_respond_to
    #refute_same
  end

  def test_skip_skips_the_current_test
    assert_raises MiniTest::Skip do
      skip
      exit
    end
  end
end
