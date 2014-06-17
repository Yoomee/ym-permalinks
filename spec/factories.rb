FactoryGirl.define do

  factory :dummy_resource do |f|
    f.name "Dummy resource"
  end

  factory :page do
    sequence(:title) { |n| "Page title #{n}"}
    text 'lots of text here '
  end

  factory :permalink do |f|
    f.path "page-title"
    f.association :resource, :factory => :dummy_resource
  end

end
