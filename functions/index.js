// The Cloud Functions for Firebase SDK to create Cloud Functions and set up triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access Firestore.
//const admin = require('firebase-admin');
//admin.initializeApp();


const { Client, Environment } = require("square");
const crypto = require('crypto');

// Initialized the Square Api client:
//   Set environment
//   Set access token
const defaultClient = new Client({
  environment: Environment.Sandbox,
  accessToken: "EAAAEPAWJrGb3PKOUOQFfEoux8EInMiHVmam7NSvwd6VSm-VZUuMBUtOcj8qVwjb",
});

const { paymentsApi, ordersApi } = defaultClient;

exports.chargeForShirt = functions.https.onRequest( async (request, response) => {

//    const requestBody = request.body;
   const nonce = request.body.nonce;
//   const totalAmount = request.body.totalAmount;
    try {
      const locationId =  'LT74CKGPBFMJC';
      const createOrderRequest = getOrderRequest(locationId);
      const createOrderResponse = await ordersApi.createOrder(createOrderRequest);

      const createPaymentRequest = {
        idempotencyKey: crypto.randomBytes(12).toString('hex'),
        sourceId: nonce,
        amountMoney: {
          ...createOrderResponse.result.order.totalMoney,
        },
        orderId: createOrderResponse.result.order.id,
        autocomplete: true,
        locationId,
      };
      const createPaymentResponse = await paymentsApi.createPayment(createPaymentRequest);

      console.log(createPaymentResponse.result.payment);
      response.status(200).json(createPaymentResponse.result.payment);
    } catch (e) {
//      console.log(e);
      console.log(
        `[Error] Status:${e.statusCode}, Messages: ${JSON.stringify(e.errors, null, 2)}`);

      sendErrorMessage(e.errors, response);
    }
  });

  function getOrderRequest(locationId) {
    return {
      idempotencyKey: crypto.randomBytes(12).toString('hex'),
      order: {
        locationId: locationId,
        lineItems: [
          {
            name: "Cookie 🍪",
            quantity: "1",
            basePriceMoney: {
              amount: 100,
              currency: "USD"
            }
          }
        ]
      }
    }
  }

  function sendErrorMessage(errors, response) {
    switch (errors[0].code) {
      case "UNAUTHORIZED":
        response.status(401).send({
            errorMessage: "Server Not Authorized. Please check your server permission."
        });
        break;
      case "GENERIC_DECLINE":
        response.status(400).send({
            errorMessage: "Card declined. Please re-enter card information."
        });
        break;
      case "CVV_FAILURE":
        response.status(400).send({
            errorMessage: "Invalid CVV. Please re-enter card information."
        });
        break;
      case "ADDRESS_VERIFICATION_FAILURE":
        response.status(400).send({
            errorMessage: "Invalid Postal Code. Please re-enter card information."
        });
        break;
      case "EXPIRATION_FAILURE":
        response.status(400).send({
            errorMessage: "Invalid expiration date. Please re-enter card information."
        });
        break;
      case "INSUFFICIENT_FUNDS":
        response.status(400).send({
            errorMessage: "Insufficient funds; Please try re-entering card details."
        });
        break;
      case "CARD_NOT_SUPPORTED":
        response.status(400).send({
            errorMessage: "	The card is not supported either in the geographic region or by the MCC; Please try re-entering card details."
        });
        break;
      case "PAYMENT_LIMIT_EXCEEDED":
        response.status(400).send({
            errorMessage: "Processing limit for this merchant; Please try re-entering card details."
        });
        break;
      case "TEMPORARY_ERROR":
        response.status(500).send({
            errorMessage: "Unknown temporary error; please try again;"
        });
        break;
      default:
        response.status(400).send({
            errorMessage: "Payment error. Please contact support if issue persists."
        });
        break;
    }
  }