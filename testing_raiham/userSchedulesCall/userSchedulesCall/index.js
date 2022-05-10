const aws = require("aws-sdk");
var lambda = new aws.Lambda({
    region: 'us-west-2' //change to your region
});

const updateDB = async (databaseEvent) => {
    console.log('invoking lambda')
    const res = await lambda.invoke({
        FunctionName: 'rds-connection',
        Payload: JSON.stringify(databaseEvent) // pass params
    }
    ).promise()
    if (res) {
        if (res.Payload) {
            console.log('something returned')
            const payload = JSON.parse(res.Payload)
            const payloadBody = JSON.parse(payload.body)
            return payloadBody
        } else {
            return "nothing returned"
        }
    } else {
        return "less than nothing returned"
    }

}

exports.handler = async (event) => {
    try {
        const body = JSON.parse(event.body)

        const userID = body['userID']
        const startDateTime = body['startDateTime']

        const sqlCommand = `call userMakesAppointment(${userID}, '${startDateTime}')`

        let dbEvent = {
            "action": "raw",
            "raw": sqlCommand
        }

        const dbResponse = await updateDB(dbEvent)

        const response = {
            statusCode: 200,
            body: JSON.stringify({ sqlCommand, response: dbResponse }),
        };
        return response;
    } catch (error) {
        console.log(error)
        const response = {
            statusCode: 400,
            body: JSON.stringify({ error: error }),
        };
        return response;
    }
};
