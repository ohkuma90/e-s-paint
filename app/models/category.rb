class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '下塗り：水性' },
    { id: 3, name: '下塗り：溶剤系' },
    { id: 4, name: '上塗り：水性' },
    { id: 5, name: '上塗り：溶剤系' },
  ]

  include ActiveHash::Associations
  has_many :stocks
end