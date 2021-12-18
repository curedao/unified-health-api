<?php

use App\Models\ConnectedAccount;
use App\Models\User;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//Route::get('/', function () {
//    return view('welcome');
//});

Route::middleware(['auth:sanctum', 'verified'])->get('/', function () {
    return view('dashboard');
})->name('dashboard');

Route::middleware(['auth:sanctum', 'verified'])->get('/dashboard', function () {
    return view('dashboard');
})->name('dashboard');

Route::get('/auth/{connectorSlug}/redirect', function (string $connectorSlug) {
    return Socialite::driver($connectorSlug)->redirect();
});

Route::get('/auth/{connectorSlug}/callback', function (string $connectorSlug) {
    //$user = Socialite::driver($connectorSlug)->user();

    $connectorUser = Socialite::driver($connectorSlug)->user();

    $user = ConnectedAccount::whereProvider($connectorSlug.'_id', $connectorUser->id)->first();

    if ($user) {
        $user->update([
            'github_token' => $connectorUser->token,
            'github_refresh_token' => $connectorUser->refreshToken,
        ]);
    } else {
        $user = User::create([
            'name' => $connectorUser->name,
            'email' => $connectorUser->email,
            $connectorSlug.'_id' => $connectorUser->id,
            $connectorSlug.'_token' => $connectorUser->token,
            $connectorSlug.'_refresh_token' => $connectorUser->refreshToken,
        ]);
    }

    Auth::login($user);

    return redirect('/dashboard');
});
