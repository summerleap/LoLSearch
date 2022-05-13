Rails.application.routes.draw do
  root 'search#search'
  get 'search', to: "search#search"
end
