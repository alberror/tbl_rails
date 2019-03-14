Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#locale_switch'

  localized do
    root 'application#home', as: :root
    get 'terms', to: 'application#terms', as: :terms
  end

  match '*slug' => 'application#locale_switch', via: :all if Rails.env.production?
end
