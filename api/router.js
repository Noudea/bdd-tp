import validateHandler from './utils/routerValidation.js'

export default (controlers, app) => {

  const orderSchema = {
    orderDate: { type: 'string', format: 'YYYY-MM-DD' },
    recipeId: { type: 'string', format: 'uuid' },
    quantity: { type: 'int' },
    userId: { type: 'string', format: 'uuid' }
  }


  const recipeSchema = {
    name: { type: 'string' },
    ingredients: { type: 'string' },
    procedure: { type: 'string' }
  }

  const userSchema = {
    lastName: { type: 'string' },
    firstName: { type: 'string' },
    birthDate: { type: 'string', format: 'YYYY-MM-DD' },
    address: { type: 'string' },
    phone: { type: 'string', format: 'FR-phone' },
    email: { type: 'string' }
  }


  const routes = [
    {
      method: 'get',
      path: '/status',
      handler: controlers.statusCtrl.getStatus
    },
    {
      method: 'get',
      path: '/recipes/:id',
      handler: controlers.recipeCtrl.get,
      validation: {
        params: {
          id: { type: 'string', format: 'uuid' }
        }
      }
    },
    {
      method: 'get',
      path: '/recipes',
      handler: controlers.recipeCtrl.list,
    },
    {
      method: 'post',
      path: '/recipes',
      handler: controlers.recipeCtrl.create,
    },
    {
      method : 'put',
      path : '/recipes/:id',
      handler : controlers.recipeCtrl.update,
      validation: {
        params: {
          id: { type: 'string', format: 'uuid' }
        }
      }
    },
    {
      method : 'delete',
      path : '/recipes/:id',
      handler : controlers.recipeCtrl.del,
      validation: {
        params: {
          id: { type: 'string', format: 'uuid' }
        }
      }
    },
    {
      method : 'get',
      path : '/users/:id',
      handler : controlers.userCtrl.get,
      validation: {
        params: {
          id: { type: 'string', format: 'uuid' }
        }
      }
    },
    {
      method : 'get',
      path : '/users',
      handler : controlers.userCtrl.list
    },
    {
      method : 'post',
      path : '/users',
      handler : controlers.userCtrl.create,
      validation: {
        body: {
          ...userSchema
        }
      }
    },
    {
      method : 'put',
      path : '/users/:id',
      handler : controlers.userCtrl.update,
      validation: {
        params: {
          id: { type: 'string', format: 'uuid' }
        },
        body: {
          ...userSchema
        }
      }
    },
    {
      method : 'delete',
      path : '/users/:id',
      handler : controlers.userCtrl.del,
      validation: {
        params: {
          id: { type: 'string', format: 'uuid' }
        }
      }
    },
    {
      method : 'get',
      path : '/orders/:id',
      handler : controlers.orderCtrl.get,
      validation: {
        params: {
          id: { type: 'string', format: 'uuid' }
        }
      }
    },
    {
      method : 'get',
      path : '/orders',
      handler : controlers.orderCtrl.list
    },
    {
      method : 'post',
      path : '/orders',
      handler : controlers.orderCtrl.create,
      validation: {
        body: {
          ...orderSchema
        }
      }
    },
    {
      method : 'put',
      path : '/orders/:id',
      handler : controlers.orderCtrl.update,
      validation: {
        params: {
          id: { type: 'string', format: 'uuid' }
        },
        body: {
          ...orderSchema
        }
      }
    },
    {
      method : 'delete',
      path : '/orders/:id',
      handler : controlers.orderCtrl.del,
      validation: {
        params: {
          id: { type: 'string', format: 'uuid' }
        }
      }
    }
  ]

  routes.forEach(route => {
    app[route.method](route.path,validateHandler(route), route.handler)
  })
}
