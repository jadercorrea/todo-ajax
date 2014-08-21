FactoryGirl.define do
  factory :sub_task do
    description "Factory SubTask"
    association :task
  end
end
