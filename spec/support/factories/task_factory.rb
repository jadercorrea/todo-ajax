FactoryGirl.define do
  factory :task do
    description "Factory Task"
    finished false

    after(:create) do |task|
      FactoryGirl.create(:sub_task, task: task)
    end
  end
end
