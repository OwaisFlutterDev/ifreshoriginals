// The Cloud Functions for Firebase SDK to create Cloud Functions and set up triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
admin.initializeApp();

//const express = require('express');
//const app = express();
const { Client, Environment } = require("square");
const crypto = require('crypto');
const bodyParser = require('body-parser');

//app.use(bodyParser.urlencoded({ extended: false }));
//app.use(bodyParser.json());

// Initialized the Square Api client:
//   Set environment
//   Set access token
const defaultClient = new Client({
  environment: process.env.ENVIRONMENT === "PRODUCTION" ? Environment.Production : Environment.Sandbox,
  accessToken: process.env.ACCESS_TOKEN,
});

const { paymentsApi, ordersApi, locationsApi, customersApi } = defaultClient;

exports.chargeCustomerCard = functions.https.onRequest( async (request, response) => {

  const requestBody = request.body;

    try {
      const listLocationsResponse = await locationsApi.listLocations();
      const locationId = process.env.LOCATION_ID;
      const createOrderRequest = getOrderRequest(locationId);
      const createOrderResponse = await ordersApi.createOrder(createOrderRequest);
      const createPaymentRequest = {
        idempotencyKey: crypto.randomBytes(12).toString('hex'),
        customerId: requestBody.customer_id,
        sourceId: requestBody.customer_card_id,
        amountMoney: {
          ...createOrderResponse.result.order.totalMoney,
        },
        orderId: createOrderResponse.result.order.id
      };
      const createPaymentResponse = await paymentsApi.createPayment(createPaymentRequest);
      console.log(createPaymentResponse.result.payment);

      response.status(200).json(createPaymentResponse.result.payment);
    } catch (e) {
      console.log(
        `[Error] Status:${e.statusCode}, Messages: ${JSON.stringify(e.errors, null, 2)}`);

      sendErrorMessage(e.errors, response);
    }
});






