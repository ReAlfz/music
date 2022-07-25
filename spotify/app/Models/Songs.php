<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Songs extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    protected $fillable = [
        'artist_id',
        'title',
        'image_url',
        'songs_url',
    ];

    public function artist(){
        return $this->belongsTo(Artist::class);
    }
}