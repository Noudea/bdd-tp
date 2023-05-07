import { v4 as uuidv4 } from 'uuid';

export default ({ Model }) => {
  const data = [
    new Model({
      id: 'a35ce12d-d52b-4a07-90ad-68e985b779e7',
      name: 'Chausson aux pommes',
      ingredients: 'pommes, pate feuilletée, sucre',
      procedure: 'faire compote, former chausson, cuire'
    }),
    new Model({
      id: 'dc466424-4297-481a-a8de-aa0898852da1',
      name: 'Quiche thon tomate',
      ingredients: 'thon, tomate, pate feuilletée, oeuf, creme',
      procedure: 'couper thon, tomates, mélanger creme et oeufs, mettre dans moule, cuire'
    })
  ]

  const list = () => {
    return data;
  }

  const create = (dataToCreate) => {
    const createdData = new Model({
      id: uuidv4(),
      ...dataToCreate
    })

    data.push(createdData)
    return createdData
  }

  const get = (id) => {
    return data.find((b) => { return b.id === id})
  }

  const update = (updatedData) => {
    const dataIndexToReplace = data.findIndex((b) => {
      return b.id === updatedData.id})
    data[dataIndexToReplace] = updatedData
    return updatedData
  }

  const del = (id) => {
    const dataIndexToDelete = data.findIndex((b) => { return b.id === id})
    const deletedData = data[dataIndexToDelete]
    data.splice(dataIndexToDelete,1)
    return deletedData
  }

  return {
    list,
    get,
    create,
    update,
    del
  }
}
