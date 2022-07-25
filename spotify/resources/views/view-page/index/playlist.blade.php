@extends('master')

@section('content')

<div class="playlist">
    <div class="cover">
        <div class="cover-image">
            <img src="{{ $current_songs->image_url }}" alt="avatar" />
        </div>
    </div>
    
    <div class="player">
        <audio class="player_audio">
            <source src={{ $current_songs->songs_url }} type="audio/mp3">
        </audio>
        <div class="song-panel">
            <div class="song-info">
                <div class="song-info__title">{{ $current_songs->title }}</div>
                <div class="song-info__artist">{{ $current_songs->artist->name }}</div>
                <div class="progress">
                    <div class="progress_filled"></div>
                </div>
            </div>
        </div>

        <div class="player-controls">
            <div class="spinner">
                <div class="spinner__disc" style="background-image: 
                url({{ $current_songs->image_url }})">
                    <div class="center__disc"></div>
                </div>
            </div>
            
            <button class="backward">
                <a href="">
                    <i class="fa fa-backward" style="font-size:25px;"></i>
                </a>
            </button>

            <button class="play">
                <i class="fa fa-play" style="font-size:25px;"></i>
                <span class="pause left"></span>
                <span class="pause right"></span>
            </button>

            <button class="forward" style="font-size:25px;">
                <i class="fa fa-forward"></i>
            </button>
        </div>
    </div>
</div>

@endsection
