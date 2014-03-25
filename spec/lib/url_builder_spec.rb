require_relative '../spec_helper'

describe Varese::URLBuilder do


  [
    [{ acs: 5, year: 2012 }, 'http://api.census.gov/data/2012/acs5', 'acs5'],
    [{ acs: 1, year: 2010 }, 'http://api.census.gov/data/2010/acs1', 'acs1'],
    [{ sf: 1, year: 2010 }, 'http://api.census.gov/data/2010/sf1', 'census']
  ].each do |options, expectation, description|
    specify description do 
      builder = Varese::URLBuilder.new(options)
      builder.to_str.must_equal expectation
    end
  end


  describe 'invalid urls' do
    [
      [{ acs: 5 }, 'without year'],
      [{ year: 2010 }, 'without dataset']
    ].each do |options, desc|
      specify desc do
        builder = Varese::URLBuilder.new(options)
        ->{ builder.to_str }.must_raise Varese::InvalidURLError
      end
    end
  end
end
