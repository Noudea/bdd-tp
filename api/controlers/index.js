import statusCtrl from './statusCtrl.js';
import recipeCtrl from './recipeCtrl.js'
import usrCtrl from './usrCtrl.js'
import orderCtrl from './orderCtrl.js'



export default ({ repository, dto }) => ({
  statusCtrl : statusCtrl,
  recipeCtrl : recipeCtrl({
    repo : repository.recipeRepo
  }),
  userCtrl : usrCtrl({
    repo : repository.userRepo,
    dto : dto.user
  }),
  orderCtrl : orderCtrl({
    repo : repository.orderRepo,
    dto : dto.order
  })
})
