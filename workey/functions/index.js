const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp;

exports.enterShiftNotfication = functions.database.ref('/Company Groups/{companyId}/employeeList/{employeeId}/isWorking')
.onUpdate(async (change, comtext) => {
const companyId = context.param.conpanyId;
const employeeId = context.param.employeeId;
if(!change.after.val()){
    return console.log('company', companyId, 'employee exit', employeeId);
}
console.log('company', companyId, 'employee enter', employeeId);
}
);

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


