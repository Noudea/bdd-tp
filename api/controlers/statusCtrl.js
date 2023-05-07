
const getStatus = (_, res) => {
  console.log('api is ok');
  res.send({
    data: {
      api: 'ok'
    }
  });
};

export default {
  getStatus
};
