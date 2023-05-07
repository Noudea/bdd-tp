

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

    const user = repo.get(id)

    if(!user){
      return res.status(404).send({
        error: {
          message: 'User not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }

    res.status(200).send({
      data: dto(user)
    })
  }

  const create = (req,res) => {
    res.status(201).send({
      data: dto(repo.create(req.body))
    })
  }

  const update = (req,res) => {

    const user = repo.get(req.params.id)

    if(!user){
      return res.status(404).send({
        error: {
          message: 'User not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }

    res.status(200).send({
      data: dto(repo.update({
        id: req.params.id,
        ...req.body
      }))
    })
  }

  const del = (req,res) => {
    const {id } = req.params;

    const user = repo.get(id)

    if(!user){
      return res.status(404).send({
        error: {
          message: 'User not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }

    res.status(200).send({
      meta: {
        _deleted: dto(user)
      }
    })
  }

  return {
    list,
    create,
    update,
    del,
    get
  }
}
