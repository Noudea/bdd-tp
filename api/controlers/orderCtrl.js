import userRepo from '../repository/userRepo.js'
import model from '../Model/index.js'
import recipeRepo from '../repository/recipeRepo.js'

export default ({ repo, dto  }) => {
  const list = async (_,res) => {
    const dataList = repo.list()

    const promises = dataList.map((data) => {
      return dto(data)
    })

    await Promise.all(promises)

    return res.status(200).send({
      data: promises
    })
  }

  const get = (req,res) => {
    const {id } = req.params;

    const order = repo.get(id)
    if(!order) {
      return res.status(404).send({
        error :{
          message: 'Order not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }

    res.status(200).send({
      data: dto(order)
    })
  }

  const create = (req,res) => {

    //check order date
    const dateofOrder = new Date(req.body.orderDate)
    if(dateofOrder < new Date()) {
      return res.status(400).send({
        error :{
          message: 'orderDate must be in the future',
          status: 400,
          code: 'BAD_REQUEST'
        }
      })
    }

    //check if user exists
    const user = userRepo(
      {
        Model: model.User
      }
    ).get(req.body.userId)
    if(!user) {
      return res.status(404).send({
        error :{
          message: 'User not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }

    //check if recipe exists
    const recipe = recipeRepo({
      Model: model.Recipe
    }).get(req.body.recipeId)
    if(!recipe) {
      return res.status(404).send({
        error :{
          message: 'Recipe not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }


    res.status(201).send({
      data: dto(repo.create({
        orderDate: new Date(req.body.orderDate),
        ...req.body,
      }))
    })
  }

  const update = (req,res) => {

    const order = repo.get(req.params.id)
    if(!order) {
    console.log('undefined')
      return res.status(404).send({
        error :{
          message: 'Order not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }


    //check order date
    const dateofOrder = new Date(req.body.orderDate)
    if(dateofOrder < new Date()) {
      return res.status(400).send({
        error :{
          message: 'orderDate must be in the future',
          status: 400,
          code: 'BAD_REQUEST'
        }
      })
    }

    //check if user exists
    const user = userRepo(
      {
        Model: model.User
      }
    ).get(req.body.userId)
    if(!user) {
      return res.status(404).send({
        error :{
          message: 'User not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }

    //check if recipe exists
    const recipe = recipeRepo({
      Model: model.Recipe
    }).get(req.body.recipeId)
    if(!recipe) {
      return res.status(404).send({
        error :{
          message: 'Recipe not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }
    res.status(200).send({
      data: dto(repo.update(dto({
        id: req.params.id,
        ...req.body })))
    })
  }

  const del = (req,res) => {
    const {id } = req.params;

    const order = repo.get(id)
    if(!order) {
      return res.status(404).send({
        error :{
          message: 'Order not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }

    res.status(200).send({
      meta: {
        _deleted: dto(order)
      }
    })
  }

  return {
    list,
    get,
    create,
    update,
    del
  }
}
