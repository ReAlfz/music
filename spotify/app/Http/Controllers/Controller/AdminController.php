<?php

namespace App\Http\Controllers\Controller;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use \App\Models\Songs;
use \App\Models\Artist;
use \App\Models\User;

class AdminController extends Controller {
    public function addSongs() {
		return view('view-page/admin/addSongs');
	}

	public function addArtist() {
		return view('view-page/admin/addArtist');
	}

    public function homeSongs() {
		return view('view-page/admin/songs', [
			'data' => Songs::paginate(10),
		]);
	}

	public function homeArtist() {
		return view('view-page/admin/artist', [
			'data' => Artist::paginate(10),
		]);
	}

	// CRUD Artist
	public function addDataArtist(Request $request) {
		$validate = Artist::where('name', $request->name)->first();

		if ($validate == null) {
			Artist::insert([
				'name' => $request->name,
				'image_url' => $request->image,
			]);
		} else {
			return redirect('/admin/artist/add');
		}

		return redirect('admin/artist');
	}

    // CRUD Songs
	public function addDataSongs(Request $request) {
		$validate = Songs::where('title', $request->title)->first();
		$artist_id = Artist::where('name', $request->artist)->first();

		if ($validate == null) {
			Songs::insert([
				'artist_id' => $artist_id->id,
				'title' => $request->title,
				'image_url' => $request->image,
				'songs_url' => $request->url,
			]);
		} else {
			return redirect('/admin/songs/add');
		}

		return redirect('/admin/songs');
	}

	public function removeSongs(Songs $songs) {
		$id = $songs->id;
		Songs::where('id', $id)->delete();
		return redirect('/admin/songs');
	}

	public function removeArtist(Artist $artist) {
		$id = $artist->id;
		Artist::where('id', $id)->delete();
		return redirect('/admin/artist');
	}
}