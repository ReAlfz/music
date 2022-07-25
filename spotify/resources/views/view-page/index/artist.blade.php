@extends('master')

@section('content')

<div class="home">
    <div class="up">
        <div class="grid">
            @foreach ($songs as $item)
                <div class="card">
                    <img src="{{ $item->image_url }}" alt="avatar">
                    <div class="text-content">
                        <h5><b>{{ $item->title }}</b></h5>
                        <a href="{{ url('artist/'. $item->artist->id) }}">{{ $item->artist->name }}</a>
                    </div>
                </div>
            @endforeach
        </div>
    </div>
</div>

@endsection
