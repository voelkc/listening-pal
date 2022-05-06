//var mysql = require('mysql')
var Knex = require('knex')

const host = 'pal-db.cb5vbqoctyvg.us-west-2.rds.amazonaws.com'
const user = 'admin'
const password = 'kGyScJDgoNlCf7Id'
const database = 'ListeningPal'

const archive = []

const connection = {
    ssl: { rejectUnauthorized: false },
    host,
    user,
    password,
    database,
}

const knex = Knex({
    client: 'mysql',
    connection,
})

const handler = async function (event, context) {
    try {
        // create timestamp
        const date = new Date
        const now = date.getTime()

        // check against the archive
        if (archive.length > 0) {
            const lastAction = archive[archive.length - 1]
            console.log(typeof event)
            if (JSON.stringify(event) === JSON.stringify(lastAction.request)) {
                console.log('we have a duplicate')
                if (lastAction.timestamp + 2000 > now) {
                    console.log('uh oh its too soon')
                    throw 'Duplicate Request Exception'
                }
            }
        }
        //update the archive
        archive.push({ timestamp: now, request: event })
        console.log(archive)


        const action = event['action']
        let res = 'nothing happened' // default value, should be updated....unless nothing happened
        if (action === 'insert') { // if you are inserting, you need 'table' and 'value' params in your request.
            console.log('inserting')
            res = await knex(event['table']).insert(event['values'])
            console.log(res)
        } else if (action === 'read') { // if you are reading, you need 'table' 'select' (the fields you are selecting) and 'where' (filters, with each sql value as its own string: 'UserID', '=', '4')
            console.log('reading')
            console.log(event['table'])
            console.log(event['where'])
            console.log(event['select'])
            //res = await knex(event['table']).where(event['where'][0], event['where'][1], event['where'][2]).select(event['select'])
            res = await knex.select('*').from(event['table'])
            return response;
        } else if (action === 'update') { // if you are updating a table entry, you need 'table', 'values' and 'where' params.
            console.log('updating')
            res = await knex(event['table']).where(event['where']).update(event['values'])
        } else if (action === 'delete') { // if you are deleting a table entry, you need 'table' and 'where' params'
            console.log('deleting')
            res = await knew(event['table'].where(event['where']).del())
        } else if (action === 'raw') { // just one param: 'raw' - made up of actual SQL code to inject.
            console.log('raw dogging it')
            res = await knex.raw(event['raw'])
        } else {
            console.log('no action found')
            return {
                statusCode: 400,
                body: JSON.stringify('no db action specified'),
            };
        }
        const response = {
            statusCode: 200,
            body: JSON.stringify(res),
        };
        return response
    } catch (err) {
        console.log(err)
        return {
            statusCode: 400,
            body: JSON.stringify(err),
        };
    }
}

module.exports = {
    handler
}