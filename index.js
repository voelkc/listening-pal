exports.handler = async (event) => {
    // need to get FK UserID and ListenerID 
    // from tblPayment grab usercreditsbefore/after and userID then input into tblappt
    const paymentID = event['PaymentID']
    const userID = event['UserID']
    // const email = event['email']
    const credsBefore = event['UserCreditsBefore']
    const credsAfter = event['UserCreditsAfter']
    // const pseud = event['Pseudonym']
    // const callCount = event['CallCount']
    // const avail = event['Availability'] //idk yet what connor labeled it
    
    let event = {
        "action": "read",
        "table": "tblPAYMENT",
        "values": {
            "UserID":UserID
        }
    }
    
    // make appointment
    let event2 = {
        "action": "input",
        "table": "tblAPPOINTMENT",
        "values": {
            "UserID":UserID,
            "ListenerID":ListenerID
            "StartTime":""
        }
    }

    const response = {
        'event': JSON.stringify(event),
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!'),
    };
    return response;
};
