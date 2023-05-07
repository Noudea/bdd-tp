import chai from 'chai';
import chaiHttp from 'chai-http';
import { Given, When, Then } from '@cucumber/cucumber';
import { StatusCodes } from 'http-status-codes';
import api from '../../index.js';

// IMPORTANT : For Cucumber working, always use function () {}
// (never () => {})

chai.use(chaiHttp);

Then('I should have response {string}', function(expectedStatusCode) {
  chai.expect(this.response).to.have.status(StatusCodes[expectedStatusCode]);
});

Then('following {string} item:', function(type,expectedData) {
  if(type === 'order') {
    return chai.expect(this.response.body.data).to.deep.equal({
      ...expectedData.hashes()[0],
      quantity: parseInt(expectedData.hashes()[0].quantity)
    })
  }

  if(type === 'error') {
    return chai.expect(this.response.body.error).to.deep.equal({
      ...expectedData.hashes()[0],
      status: parseInt(expectedData.hashes()[0].status)
    })
  }
  chai.expect(this.response.body).to.deep.equal({
    data: expectedData.hashes()[0]
  });
});

When('I list the {string}', async function (type) {
  const res = await chai.request(api).get(`/${type}`);
  this.response = res;
});

Then(/^following "([^"]*)" list:$/,  function (type, expectedData) {

  let data = expectedData.hashes()
  if(type === 'orders') {
      data = data.map((order) => {
       return { ...order, quantity: parseInt(order.quantity) }
     })
  }

  chai.expect(this.response.body).to.deep.equal({
    data
  })

});

When(/^I create the following "([^"]*)"$/, async function (type, data) {

  let dataToCreate = data.hashes()[0]

  if(type === 'order') {
    dataToCreate = {
      ...dataToCreate,
      quantity: parseInt(dataToCreate.quantity)
    }
  }

  const res = await chai.request(api).post(`/${type}s`).send(dataToCreate);
  this.response = res;
});

Then(/^following new "([^"]*)" item$/, function (type,expectedData) {
  const {id,...responseData} = this.response.body.data

  if(type === 'order') {
      return chai.expect(responseData).to.deep.equal({
      ...expectedData.hashes()[0],
      quantity: parseInt(expectedData.hashes()[0].quantity)
    }) }

  chai.expect(responseData).to.deep.equal(
    expectedData.hashes()[0]
  )
  chai.expect(id).to.have.lengthOf(36)
});

Given("a {string} with id {string}", function (type,id) {
  this.id = id
});

When('I get the {string}', async function(type) {
  if(type === 'status') {
    const res = await chai.request(api).get(`/${type}`);
    this.response = res;
    return
  }
  const res = await chai.request(api).get(`/${type}/${this.id}`);
  this.response = res;
});

When('I update the following {string} with following data:', async function (type,data) {
  const res = await chai.request(api).put(`/${type}s/${this.id}`).send({
    ...data.hashes()[0],
  });
  this.response = res;
});


When("I delete the {string}", async function (type) {
  const res = await chai.request(api).delete(`/${type}s/${this.id}`);
  this.response = res;
});
Then('following {string} deleted item:', function (type,expectedData) {
  if(type === 'order') {
    const data = expectedData.hashes().map((order) => {
      return { ...order, quantity: parseInt(order.quantity) }
    })
   return chai.expect(this.response.body).to.deep.equal({
     meta : {
       _deleted: data[0]
     }
   })
  }
  chai.expect(this.response.body).to.deep.equal({
    meta : {
      _deleted: expectedData.hashes()[0]
    }
  })
});



