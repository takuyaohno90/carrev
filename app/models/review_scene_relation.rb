class ReviewSceneRelation < ApplicationRecord
  belongs_to :review
  belongs_to :scene
end
