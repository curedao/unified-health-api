<?php

namespace App\Actions\Socialstream;

use JoelButcher\Socialstream\ConnectedAccount;
use JoelButcher\Socialstream\Contracts\CreatesConnectedAccounts;
use JoelButcher\Socialstream\Socialstream;
use Laravel\Socialite\Contracts\User as ProviderUser;

class CreateConnectedAccount implements CreatesConnectedAccounts
{
    /**
     * Create a connected account for a given user.
     *
     * @param  mixed  $user
     * @param  string  $provider
     * @param ProviderUser $providerUser
     * @return ConnectedAccount
     */
    public function create($user, string $provider, ProviderUser $providerUser)
    {
        return Socialstream::connectedAccountModel()::forceCreate([
            'user_id' => $user->id,
            'provider' => strtolower($provider),
            'provider_id' => $providerUser->getId(),
            'name' => $providerUser->getName(),
            'nickname' => $providerUser->getNickname(),
            'email' => $providerUser->getEmail(),
            'avatar_path' => $providerUser->getAvatar(),
            'token' => $providerUser->token,
            'secret' => $providerUser->tokenSecret ?? null,
            'refresh_token' => $providerUser->refreshToken ?? null,
            'expires_at' => property_exists($providerUser, 'expiresIn') ? now()->addSeconds($providerUser->expiresIn) : null,
        ]);
    }
}
