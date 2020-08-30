# xz_stripe_payment

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

-   [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
-   [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# create new payment steps

-   create payment method (via new card or existing card)
-   create payment intent (set amount)
-   confirm payment (require client secret and payment method id)

# for api key, need to create as below

> lib>utilities>keys.dart
> const String API_SECRET = '<api_secret>';
> const String PUBLISHED_KEY = '<published_key>';
