<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Artist extends Model
{
    use HasFactory;
    
    protected $guarded = ['id'];

    protected $fillable = [
        'name',
        'image_url'
    ];

    public function songs(){
        return $this->hasMany(Songs::class);
    }
}