import recipeRepo from './recipeRepo.js'
import userRepo from './userRepo.js'
import orderRepo from './orderRepo.js'

export default (model) => ({
  recipeRepo: recipeRepo({
    Model: model.Recipe
  }),
  userRepo: userRepo({
    Model: model.User
  }),
  orderRepo: orderRepo({
    Model: model.Order
  })
})
