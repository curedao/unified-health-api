<?php

namespace App\Actions\Socialstream;

use JoelButcher\Socialstream\Contracts\HandlesInvalidState;
use Laravel\Socialite\Two\InvalidStateException;

class HandleInvalidState implements HandlesInvalidState
{
    /**
     * Handle an invalid state exception from a Socialite provider.
     *
     * @param InvalidStateException $exception
     * @param callable|null $callback
     * @return mixed
     */
    public function handle(InvalidStateException $exception, callable $callback = null)
    {
        if ($callback) {
            return $callback($exception);
        }
        return redirect()->back()->withErrors($exception->getMessage());


        throw $exception;
    }
}
