@extends('admin')

@section('content')

<div class="wrapper flex_box">
    <form action="{{ url("/admin/artist/addArtist") }}" method="post">
    @csrf
      <div class="input">
        <label>Name</label>
        <input class="name" name="name" placeholder="title songs" type="text">
      </div>
      
      <div class="input">
        <label>Image</label>
        <input class="name" name="image" placeholder="title songs" type="text">
      </div>

      <div class="button_wrapper">
        <button>submit</button>
      </div>
    </form>
  </div>
    
@endsection