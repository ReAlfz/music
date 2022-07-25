<?php

namespace App\Http\Controllers\Controller;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use \App\Models\Songs;
use \App\Models\Artist;
use \App\Models\User;

class DefaultController extends Controller {
    public function first(){
		$songs = Songs::paginate(15);	
		return view('view-page/index/home', [
			'judulH1' => 'All Musics',
			'songs' => $songs,
		]);
	}

	public function login() {
		return view('view-page/login');
	}

	public function search() {
		return view('view-page/index/search');
	}
	
	public function library() {
		return view('view-page/index/library');
	}

	public function auth(Request $request){
		$user = $request->username;
		$pass = $request->password;
		
		$isTrue = User::where([
			'username' => $user,
			'password' => $pass
		])->first();
		if($isTrue){
			return redirect('/admin/songs');
		} else {
			return redirect('/login');
		}
	}

	public function artist(Artist $artist){
		$id = $artist->id;
		$songs = Songs::where('artist_id', $id)->get();
		return view('view-page/index/artist', [
			'judulH1' => 'Artist'.$artist->name,
			'songs' => $songs,
		]);
	}

	public function playlist(Songs $songs) {
		return view('view-page/index/playlist', [
			'current_songs' => $songs,
			'array' => Songs::all()
		]);
	}
}