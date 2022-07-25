<?php

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
use App\Http\Controllers\Controller\DefaultController;
use App\Http\Controllers\Controller\AdminController;

Route::get('/', [DefaultController::class, 'first']);
Route::get('/artist/{artist}', [DefaultController::class, 'artist']);
Route::get('/songs/{songs}', [DefaultController::class, 'playlist']);
Route::get('/login', [DefaultController::class, 'login']);
Route::get('/search', [DefaultController::class, 'search']);
Route::get('/library', [DefaultController::class, 'library']);

Route::get('/admin/songs', [AdminController::class, 'homeSongs']);
Route::get('/admin/artist', [AdminController::class, 'homeArtist']);
Route::get('/admin/songs/addSongs', [AdminController::class, 'addSongs']);
Route::get('/admin/artist/addArtist', [AdminController::class, 'addArtist']);

Route::post('/login', [DefaultController::class, 'auth']);

Route::post('/admin/artist/addArtist', [AdminController::class, 'addDataArtist']);
Route::post('/admin/songs/addSongs', [AdminController::class, 'addDataSongs']);
Route::get('/admin/songs/{songs}', [AdminController::class, 'removeSongs']);
Route::get('/admin/artist/{artist}', [AdminController::class, 'removeArtist']);