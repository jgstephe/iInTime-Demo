Factory.define :user do |u|
  u.name "Ex User"
  u.email "user2@ex.com"
  u.password "foobar"
  u.password_confirmation "foobar"
end

Factory.define :question do |q|
  q.content "content"
  q.correct "correct"
  q.other_a "wrong 1"
  q.other_b "wrong 2"
  q.other_c "wrong 3"
  q.other_d "wrong 4"
  q.title   "this question"
  q.expert_answer "expert"
  q.category "family"
end