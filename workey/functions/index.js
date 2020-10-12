'use strict';

//import { Change } from 'firebase-functions';

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { ref, DataSnapshot } = require('firebase-functions/lib/providers/database');
admin.initializeApp();


exports.shitfNotifiction = functions.database.ref('/Company Groups/{companyId}/employeeList/{employeeId}/isWorking')
.onUpdate(async (change,context) =>{
    const companyId = context.params.companyId;
    const employeeId = context.params.employeeId;

    if(change.after.val()){
        const getWorkGroupId = admin.database()
        .ref(`/Company Groups/${companyId}/employeeList/${employeeId}/workGroupId`)
        .once('value');

        const getToken = admin.database()
        .ref(`/Users/Company Accounts/${companyId}/token`)
        .once('value');

        const promiseList = await Promise.all([getWorkGroupId,getToken]);
        let workGroupId = promiseList[0];
        let token = promiseList[1];

        const getWorkGroupName = admin.database()
        .ref(`Compamy Groups/${companyId}/workGroupList/${workGroupId.val()}`)
        .once('value');

        const workGroupNamePromise = await Promise.all(workGroupName);

        let workGroupName = workGroupNamePromise;

        const payload = admin.messaging.MessagingPayload = {
            notification: {
                title: `${workGroupName.val()}`,
                body: 'test',
                click_action: 'FLUTTER_NOTIFICATION_CLICK',
            }
        };
        console.log(workGroupNamePromise, 'name', workGroupName.val());
        return admin.messaging().sendToDevice(token.val(), payload);

    }
    return console.log(context.params.companyId);

},);


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
