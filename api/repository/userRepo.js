
import { v4 as uuidv4 } from 'uuid';

export default ({ Model }) => {
  const data = [
    new Model({
      id: 'f92fefd1-4059-447b-89c6-a7e2482f7a5f',
      lastName: 'Dumbledore',
      firstName: 'Albus',
      birthDate: new Date('1950-01-01'),
      phone: '+33654543456',
      address: 'bureau du directeur,chateau de poudlard',
      email: 'albus@mail.com'
    }),
    new Model({
      id: 'c5e0357f-2eb7-4180-84e7-5c8efeab2c83',
      lastName: 'Potter',
      firstName: 'Harry',
      birthDate: new Date('1980-01-01'),
      phone: '+33654543456',
      address: 'lit numéro 2, dortoir des garçons, griffondor, chateau de poudlard',
      email: 'harry@mail.com'
    })
  ]

  const list = () => {
    return data;
  }

  const create = (dataToCreate) => {
    const createdData = new Model({
      id: uuidv4(),
      birthDate: new Date(dataToCreate.birthDate),
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
    create,
    update,
    del,
    get
  }
}

