<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'mailgun' => [
        'domain' => env('MAILGUN_DOMAIN'),
        'secret' => env('MAILGUN_SECRET'),
        'endpoint' => env('MAILGUN_ENDPOINT', 'api.mailgun.net'),
    ],

    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_CLIENT_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],

//    'sparkpost' => [
//        'secret' => env('SPARKPOST_SECRET'),
//    ],

    'stripe' => [
        'model'  => App\Models\User::class,
        'key'    => env('STRIPE_KEY'),
        'secret' => env('STRIPE_SECRET'),
    ],

    'facebook' => [
        'client_id'     => env('CONNECTOR_FACEBOOK_CLIENT_ID'),
        'client_secret' => env('CONNECTOR_FACEBOOK_CLIENT_SECRET'),
        'redirect'      => env('CONNECTOR_FACEBOOK_REDIRECT', env('APP_URL') . '/oauth/facebook/callback'),
    ],

    'twitter' => [
        'client_id'     => env('CONNECTOR_TWITTER_CLIENT_ID'),
        'client_secret' => env('CONNECTOR_TWITTER_CLIENT_SECRET'),
        'redirect'      => env('CONNECTOR_TWITTER_REDIRECT', env('APP_URL') . '/oauth/twitter/callback'),
    ],

    'google' => [
        'client_id'     => env('CONNECTOR_GOOGLE_CLIENT_ID'),
        'client_secret' => env('CONNECTOR_GOOGLE_CLIENT_SECRET'),
        'redirect'      => env('CONNECTOR_GOOGLE_REDIRECT', env('APP_URL') . '/oauth/google/callback'),
    ],

    'github' => [
        'client_id'     => env('CONNECTOR_GITHUB_CLIENT_ID'),
        'client_secret' => env('CONNECTOR_GITHUB_CLIENT_SECRET'),
        'redirect'      => env('CONNECTOR_GITHUB_REDIRECT', env('APP_URL') . '/oauth/github/callback'),
    ],

//    'youtube' => [
//        'client_id'     => env('CONNECTOR_YOUTUBE_KEY'),
//        'client_secret' => env('CONNECTOR_YOUTUBE_CLIENT_SECRET'),
//        'redirect'      => env('CONNECTOR_YOUTUBE_REDIRECT_URI', env('APP_URL') . '/oauth/youtube/callback'),
//    ],
//
//    'twitch' => [
//        'client_id'     => env('CONNECTOR_TWITCH_KEY'),
//        'client_secret' => env('CONNECTOR_TWITCH_CLIENT_SECRET'),
//        'redirect'      => env('CONNECTOR_TWITCH_REDIRECT_URI', env('APP_URL') . '/oauth/twitch/callback'),
//    ],
//
//    'instagram' => [
//        'client_id'     => env('CONNECTOR_INSTAGRAM_KEY'),
//        'client_secret' => env('CONNECTOR_INSTAGRAM_CLIENT_SECRET'),
//        'redirect'      => env('CONNECTOR_INSTAGRAM_REDIRECT_URI', env('APP_URL') . '/oauth/instagram/callback'),
//    ],
//
//    '37signals' => [
//        'client_id'     => env('CONNECTOR_37SIGNALS_KEY'),
//        'client_secret' => env('CONNECTOR_37SIGNALS_CLIENT_SECRET'),
//        'redirect'      => env('CONNECTOR_37SIGNALS_REDIRECT_URI', env('APP_URL') . '/oauth/37signals/callback'),
//    ],
//
    'linkedin' => [
        'client_id'     => env('CONNECTOR_LINKEDIN_KEY'),
        'client_secret' => env('CONNECTOR_LINKEDIN_CLIENT_SECRET'),
        'redirect'      => env('CONNECTOR_LINKEDIN_REDIRECT_URI', env('APP_URL') . '/oauth/linkedin/callback'),
    ],
    'fitbit' => [
        'client_id'     => env('CONNECTOR_FITBIT_KEY'),
        'client_secret' => env('CONNECTOR_FITBIT_CLIENT_SECRET'),
        'redirect'      => env('CONNECTOR_FITBIT_REDIRECT_URI', env('APP_URL') . '/oauth/fitbit/callback'),
    ],

];
