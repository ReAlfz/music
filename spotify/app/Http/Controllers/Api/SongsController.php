<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Songs;
use App\Models\Artist;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class SongsController extends Controller {
    public function songs() {
        $songs = Songs::with('artist')->get();
        $artist = Artist::with('songs')->get();

        return response([
            'total data' => $songs->count(),
            'artist' => $artist->toArray(),
            'songs' => $songs->toArray(),
        ], 200);
    }

    public function artist($id) {
        $songs = songs::where('artist_id', $id)->get();
        if ($songs != null) {
            return response([
                'total data' => $songs->count(),
                'data' => $songs->toArray()
            ]);
        } else {
            return response([
                'message' => 'no data'
            ], 403);
        }
    }
}