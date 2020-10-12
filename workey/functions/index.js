'use strict';
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { ref, DataSnapshot } = require('firebase-functions/lib/providers/database');
admin.initializeApp();



exports.enterShiftNotfication = functions.database.ref('/Company Groups/{companyId}/employeeList/{employeeId}/isWorking')
.onWrite(async(change, context) => {
const companyId = context.params.companyId;
const employeeId = context.params.employeeId;
if(change.after.val()){
    const getWorkGroupId = admin.database()
    .ref(`/Company Groups/${companyId}/employeeList/${employeeId}/workGroupId`)
    .once('value');

    const getToken = admin.auth.getUser(companyId);
    
   const promiseList = await Promise.all([getWorkGroupId,getToken]);

   let workGroupId = promiseList[0];
   let tempToken = promiseList[1];

   const token = tempToken.val();

//    if (!workGroupId[0].hasChildren()) {
//     return console.log('There are no id.');
//   }
    const getEmployeeName = admin.database().ref(`/Users/Personal Accounts/${employeeId}`).once('value')
    .then(data => {
        if(data.val()){
            var employeeName = data.val();
            console.log(employeeName);
        }
        const payload = {
            notification: {
                title: `${workGroupId[0].val()}`,
                body:`${employeeName.firstname} ${employeeName.lastName} entered a shift `,
            }
        };
        const message = admin.messaging().sendToDevice(token, payload);
        return console.log(payload);

    });

   // const employeeName = await Promise.all(getEmployeeName);

// const payload = {
//     notification: {
//         title: ''
//     }
// }
  
    return console.log('company', companyId, 'employee enter', employeeId,'id', workGroupId.val());
  
}

console.log('company', companyId, 'employee exit', employeeId,);

}
);

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
