'use strict';

//import { Change } from 'firebase-functions';

const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { ref, DataSnapshot } = require('firebase-functions/lib/providers/database');
admin.initializeApp();

var db = admin.database();

exports.shitfNotification = functions.database.ref('/Company Groups/{companyId}/employeeList/{employeeId}/isWorking')
    .onUpdate(async (change, context) => {
        const companyId = context.params.companyId;
        const employeeId = context.params.employeeId;

        const getWorkGroupId = db
            .ref(`/Company Groups/${companyId}/employeeList/${employeeId}/workGroupId`)
                .once('value');

        const getToken = db
            .ref(`/Users/Company Accounts/${companyId}/token`)
                .once('value');

        const getEmployeeFirstName = db
            .ref(`/Users/Personal Accounts/${employeeId}/firstName`)
                .once('value');

        const getEmployeeLastName = db
            .ref(`/Users/Personal Accounts/${employeeId}/lastName`)
                .once('value');

        const promiseList = await Promise.all(
            [getWorkGroupId,getToken,getEmployeeFirstName,getEmployeeLastName]
        );
        const workGroupId = promiseList[0].val();
        let token = promiseList[1];
        let employeeFirstName = promiseList[2].val();
        let employeeLastName = promiseList[3].val();

        const getWorkGroupName = db
            .ref(`/Company Groups/${companyId}/workGroupList/${workGroupId}/workGroupName`)
                .once('value');

        const workGroupNamePromise = await Promise.all([getWorkGroupName]);
        let workGroupName = workGroupNamePromise[0].val();

        if(change.after.val()){
            const payload = admin.messaging.MessagingPayload = {
                notification: {
                    title: `${workGroupName}`,
                    body: `${employeeFirstName} ${employeeLastName} entered work`,
                    click_action: 'FLUTTER_NOTIFICATION_CLICK',
                }
            };
            return admin.messaging().sendToDevice(token.val(), payload);
        }
        const payload = admin.messaging.MessagingPayload = {
            notification: {
                title: `${workGroupName}`,
                body: `${employeeFirstName} ${employeeLastName} exited work`,
                click_action: 'FLUTTER_NOTIFICATION_CLICK',
            }
        };
        return admin.messaging().sendToDevice(token.val(), payload);
    },
);

