@extends('master')

@section('content')

<div class="home">
    <div class="up">
        <div class="grid">
            @foreach ($songs as $item)
                <div class="card">
                    <img src="{{ $item->image_url }}" alt="avatar">
                    <div class="text-content">
                        <a href="{{ url('songs/'. $item->id) }}"><h5><b>{{ $item->title }}</b></h5></a>
                        <a href="{{ url('artist/'. $item->artist->id) }}">{{ $item->artist->name }}</a>
                    </div>
                </div>
            @endforeach
        </div>
    </div>

    <div class="down">
        <div class="text-center" style="margin-left: 100px;">
            <div class="container">
                <ul class="pagination">
                  {{ $songs->links() }}
                </ul>
            </div>
        </div>
    </div>
</div>

@endsection