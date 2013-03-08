require 'spec_helper'
describe Searchlogic::ActiveRecordExt::Scopes::Conditions::Condition do 
  context ".matchers" do 
    it "returns an array of all matchers for conditions" do 
      ActiveRecord::Base.all_matchers.should be_kind_of(Array)
    end
  end

  context "#association_in_method" do
    it "returns an array of the klass and next method from the original method" do 
      User.association_in_method(:orders_line_items_total).should eq(["orders", "line_items_total"])
    end

    it "returns nil when no association in the method" do 
      User.association_in_method(:username_greater_than_or_equal).should be_nil
    end
  end 

  context "#memoized_scope" do
    it "scopes should be cached" do 
      User.memoized_scopes.keys.should be_empty
      User.name_greater_than_or_equal_to("James")
      User.memoized_scopes.keys.should eq([:name_greater_than_or_equal_to])
      User.memoized_scopes[:name_greater_than_or_equal_to].to_s.should eq("GreaterThanOrEqualTo")
    end

  end

  it "should not allow conditions on columns that don't exist" do 
    expect{User.non_existant_col_equal(4).all}.to raise_error
  end

  context "#association_names" do 
    it "should return a list of association names for class" do 
      User.association_names.should eq(["company", "carts", "orders", "orders_big", "audits", "user_groups"])
    end
  end
end