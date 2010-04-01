# clear a table
Given /^I have no (\S+)$/ do |table|
  ActiveRecord::Base.connection.execute "DELETE FROM `#{table.tableize}`"
end

Given /^I have fixtures for (\S+)$/ do |table|
  ActiveRecord::Base.connection.execute "DELETE FROM `#{table.tableize}`"
  Fixtures.create_fixtures('features/fixtures', table.tableize)
end

# create a new instance, as an @underscore_named_var, and @it.
Given /^I have a new (\S+)$/ do |model|
  eval "@#{model.underscore} = #{model.classify}.new"
  eval "@it = #{model.classify}.new"
end

Given /(?:created|have)?\s+(?:a|an|another)? valid (\S+)$/ do |model|
  eval "@#{model.underscore} = Factory(:#{model.underscore})"
  y eval("@#{model.underscore}").attributes
end

Given /^the following (.+) hash$/ do |factory, tbl|
  tbl.hashes.each do |hsh|
		set = Factory(factory, hsh) #TODO
		eval("@#{factory.pluralize} = set")
	end
end

Given /^I have that (\S+)'s (\S+)$/ do |var, attribute|
  instance_variable_set :"@#{attribute}", eval("@#{var}").send(attribute)
end

# Short form test - @it - perfect for single model testing.

# assignments
When /^I set its (\S+) to "([^\"]*)"$/ do |attribute, value|
  @it.send("#{attribute}=", value)
end

# run a method without args
When /^I (\S+) it$/ do |method|
  @it.send(method)
end

# list of attributes
Then /^it should have the following attributes$/ do |table|
  table.hashes.each do |hash|
    @it.attributes.has_key?(hash['attribute']).should == true
  end
end

# associations
Then /^it should (belong to a|have one|have many) (.+)$/ do |method, association|
  @it.should.respond_to?(association)
end

# simple validity
Then /^it should\s+be valid$/ do
  @it.should be_valid
end

Then /^it should not be valid$/ do
  @it.should_not be_valid
end

# attribute value
Then /^its (\S+) should be "([^\"]*)"$/ do |attribute, value|
  @it.send("#{attribute}").to_s.should == value
end

# association count
Then /^it should\s+have (\d+) (.+)$/ do |value, association|
  if @it.send(association.pluralize).respond_to? :count
    @it.send(association.pluralize).count.should == value.to_i
  else
    @it.send(association.pluralize).size.should == value.to_i
  end
end


# Long form test - @underscore_named_var - no confusion when working with multiple models.

# assignments
When /^I set that (\S+)'s (\S+) to "([^\"]*)"$/ do |var, attribute, value|
  eval("@#{var.underscore}").send("#{attribute}=", value)
end

When /^I set that (\S+)'s (\S+) to that (\S+)'s (\S+)$/ do |var, attribute, from_var, from_attr|
  eval("@#{var.underscore}").send("#{attribute}=", eval("@#{from_var.underscore}").send("#{from_attr}"))
end

# run a method without args
When /^I (\S+) that (\S+)$/ do |method, var|
  eval("@#{var.underscore}").send(method)
end

# list of attributes
Then /^that (\S+) should have the following attributes$/ do |var, table|
  table.hashes.each do |hash|
    eval("@#{var.underscore}").attributes.has_key?(hash['attribute']).should == true
  end
end

# associations
Then /^that (\S+) should (belong to a|have one|have many) (.+)$/ do |var, method, association|
  eval("@#{var.underscore}").should.respond_to?(association)
end

# simple validity
Then /^that (\S+) should\s+be valid$/ do |var|
  eval("@#{var.underscore}").should be_valid
end

Then /^that (\S+) should not be valid$/ do |var|
  eval("@#{var.underscore}").should_not be_valid
end

# attribute value
Then /^that (\S+)'s (\S+) should be "([^\"]*)"$/ do |var, attribute, value|
  eval("@#{var.underscore}").send("#{attribute}").to_s.should == value
end

# boolean attribute
Then /^that (\S+) should be (\S+)$/ do |var, attribute|
  eval("@#{var.underscore}").send("#{attribute}").should == true
end

Then /^that (\S+) should not be (\S+)$/ do |var, attribute|
  eval("@#{var.underscore}").send("#{attribute}").should == false
end

# attribute is another var
Then /^that (\S+)'s (\S+) should be that (\S+)$/ do |var, attribute, value_var|
  eval("@#{var.underscore}").send("#{attribute}").should == eval("@#{value_var.underscore}")
end

# association count
Then /^that (\S+) should\s+have (\d+) (.+)$/ do |var, value, association|
  if eval("@#{var.underscore}").send(association.pluralize).respond_to? :count
    eval("@#{var.underscore}").send(association.pluralize).count.should == value.to_i
  else
    eval("@#{var.underscore}").send(association.pluralize).size.should == value.to_i
  end
end

# array attribute includes another var
Then /^that (\S+)'s (\S+) should include that (\S+)$/ do |var, attribute, value_var|
  eval("@#{var.underscore}").send("#{attribute}").should include(eval("@#{value_var.underscore}"))
end

# collection/table tests
Then /^for each (\S+) I should have$/ do |var, tbl|
  tbl.hashes.each do |hsh|
    o = eval("#{var.classify}.find_by_#{hsh.keys.collect{|k| k.underscore }.join("_and_")}(#{hsh.values.collect{|v| "'#{v}'"}.join(',')})")
    o.should_not == nil
  end
end
