@extends('admin')

@section('content')

<div class="wrapper flex_box">
    <form action="{{ url("/admin/songs/addSongs") }}" method="post">
    @csrf
      <div class="input">
        <label>Title</label>
        <input class="name" name="title" placeholder="title songs" type="text">
      </div>
      
      <div class="input">
        <label>Artist name</label>
        <input class="name" name="artist" placeholder="title songs" type="text">
      </div>

      <div class="input">
        <label>Image</label>
        <input class="name" name="image" placeholder="genre songs" type="text">
      </div>

      <div class="input">
        <label>Url</label>
        <input class="name" name="url" placeholder="urls songs" type="text">
      </div>

      <div class="button_wrapper">
        <button>submit</button>
      </div>
    </form>
  </div>
    
@endsection