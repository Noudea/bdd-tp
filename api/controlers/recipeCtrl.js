

export default ({ repo  }) => {
  const list = (_,res) => {
    res.send({
      data: repo.list()
    })
  }

  const get = (req,res) => {
    const {id } = req.params;

    const recipe = repo.get(id)

    if(!recipe){
      return res.status(404).send({
        error: {
          message: 'Recipe not found',
          status: 404,
          code: 'NOT_FOUND'
        }
      })
    }

    res.status(200).send({
      data: repo.get(id)
    })
  }

  const create = (req,res) => {
    res.status(201).send({
      data: repo.create(req.body)
    })
  }

  const update = (req,res) => {
    res.status(200).send({
      data: repo.update({
        id: req.params.id,
        ...req.body
      })
    })
  }

  const del = (req,res) => {
    const {id } = req.params;
    res.status(200).send({
      meta: {
        _deleted: repo.del(id)
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
