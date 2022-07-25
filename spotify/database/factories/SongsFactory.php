<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use \App\Models\Artist;

class SongsFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'artist_id' => $this->faker->randomElement(Artist::pluck('id')),
            'title' => $this->faker->name(),
            'image_url' => $this->faker->name(),
            'songs_url' => 'https://archive.org/download/llenium/Illenium%20-%20Needed%20You.mp3'
        ];
    }
}