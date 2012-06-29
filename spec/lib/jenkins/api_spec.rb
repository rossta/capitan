require 'spec_helper'

describe Jenkins::API, :vcr, :record => :new_episodes do
  let(:api) { Jenkins::API.new(configuration) }
  let(:configuration) { Jenkins.configure_for_environment }

  describe "jobs" do
    it "retrieves all jobs" do
      job_objects = api.jobs
      job_objects.map(&:name).should include("platform-master")
    end

    it "merges additional attributes" do
      job_objects = api.jobs(:foo => 'bar')
      job_object = job_objects.first
      job_object.foo.should == 'bar'
    end
  end

  describe "build" do

    it "display build attributes for job, build number" do
      build_object = api.build('platform-master-entry', 278)

      build_object.job_name.should == 'platform-master-entry'
      build_object.build_number.should == 278
      build_object.result.should == 'SUCCESS'
      build_object.built_at.should be_a(Time)
      build_object.building.should be_false
      build_object.branch_name.should == 'origin/master'
      build_object.sha.should =~ /^9b5b76e99/
    end

    it "merges additional attributes" do
      build_object = api.build('platform-master-entry', 278, :foo => 'bar')
      build_object.foo.should == 'bar'
    end

  end

  describe "branches" do

    it "displays all build numbers for branches" do
      branch_objects = api.branches('platform-master')
      branch_objects.map(&:name).should include("origin/master")
      branch = branch_objects.detect { |branch| branch.name == "origin/master" }
      branch.number.to_s.should =~ /\d+/
    end

    it "merges additional attributes" do
      branch_objects = api.branches('platform-master', :foo => 'bar')
      branch_object = branch_objects.first
      branch_object.foo.should == 'bar'
    end
  end

  describe "parse time" do

    it "translates jenkins time format YYYY-MM-DD_hh-mm-ss into datetime" do
      expected_time = Time.parse("2012-02-27 18:20:28")
      api.parse_time_from_build_id("2012-02-27_18-20-28").should == expected_time
    end
  end
end
