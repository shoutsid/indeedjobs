Indeed::Application.routes.draw do
  root to: "jobs#index"

  match 'jobs' => 'jobs#index'
end
