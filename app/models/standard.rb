class Standard < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '[非危険物]' },
    { id: 3, name: '[第4類第2石油類]' },
  ]

  include ActiveHash::Associations
  has_many :stocks
end