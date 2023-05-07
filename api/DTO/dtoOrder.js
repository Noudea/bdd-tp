import moment from 'moment'

const dtoOrder = (order) => {
  return {
    id        : order.id,
    orderDate : moment(order.orderDate).format('YYYY-MM-DD'),
    recipeId  : order.recipeId,
    quantity  : parseInt(order.quantity),
    userId    : order.userId
  }
}

export default dtoOrder
