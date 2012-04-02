require 'spec_helper'  

describe Permalink do
  
  subject { FactoryGirl.create(:permalink) }
  
  it { should belong_to(:resource) }
  it { should validate_presence_of(:path) }
  it { should validate_uniqueness_of(:path).case_insensitive }
  
  describe do  
    
    let(:permalink) { FactoryGirl.create(:permalink) } 
    
    it "is valid" do
      permalink.should be_valid
    end
    
    it "creates inactive permalink with old name" do
      old_permalink_path = permalink.path
      permalink.update_attribute(:path,'new-permalink-name')
      Permalink.find_by_path(old_permalink_path).active == false
      Permalink.find_by_path(old_permalink_path).resource == permalink.resource
    end
    
  end
  
    
end