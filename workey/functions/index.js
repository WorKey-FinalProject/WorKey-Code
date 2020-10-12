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
    
   const workGroupId = await Promise.all([getWorkGroupId]);

//    if (!workGroupId[0].hasChildren()) {
//     return console.log('There are no id.');
//   }
  
    return console.log('company', companyId, 'employee enter', employeeId,'id', workGroupId[0].val());
  
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
