FactoryGirl.define do
  factory :task, class: Task do
    content "Testing content task"
    author 1
    picked_by nil
    done false
  end

  factory :pickedTask, class: Task do
    content "Testing picked task"
    author 1
    picked_by 1
    done false
  end

  factory :doneTask, class: Task do
    content "Testing done task"
    author 1
    picked_by 1
    done true
  end
end