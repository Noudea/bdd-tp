
import { v4 as uuidv4 } from 'uuid';


export default ({ Model }) => {
  const data = [
    new Model({
      id: 'dbcbb733-8099-4aec-bbda-ddbe190440b4',
      orderDate: new Date('2023-09-20'),
      recipeId: 'a35ce12d-d52b-4a07-90ad-68e985b779e7',
      quantity: 1,
      userId: 'f92fefd1-4059-447b-89c6-a7e2482f7a5f',
    }),
    new Model({
      id: '5ebce9c0-6bfe-41f1-bce6-8824845d2deb',
      orderDate: new Date('2023-09-20'),
      recipeId: 'dc466424-4297-481a-a8de-aa0898852da1',
      quantity: 1,
      userId: 'c5e0357f-2eb7-4180-84e7-5c8efeab2c83',
    }),
  ]

  const list = () => {
    return data;
  }

  const get = (id) => {
    return data.find((b) => { return b.id === id})
  }

  const create = (dataToCreate) => {
    const createdData = new Model({
      id: uuidv4(),
      ...dataToCreate
    })

    data.push(createdData)
    // console.log('data',data)
    return createdData
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

