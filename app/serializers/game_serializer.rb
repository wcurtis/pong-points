class GameSerializer < ActiveModel::Serializer
  # embed :ids, :include => true
  attributes :id, :status
  # embed :ids
  # has_many :players

  # def title
  #   "tittle"
  # end
end
