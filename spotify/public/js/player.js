const player = document.querySelector('.player');
const audio = player.querySelector('.player_audio');
const audioSource = audio.querySelector('source');
const songPanel = player.querySelector('.song-panel');
const songTitle = player.querySelector('.song-info__title');
const songArtist = player.querySelector('.song-info__artist');
const backButton = player.querySelector('.backward');
const playButton = player.querySelector('.play');
const forwardButton = player.querySelector('.forward');
const spinner = player.querySelector('.spinner');
const spinnerDisc = player.querySelector('.spinner__disc');
const progress = player.querySelector('.progress');
const progressBar = player.querySelector('.progress_filled');

let playing = false;
let trackSwitch = false;

const togglePlay = () => {
    // Play / pause the audio
    const method = audio.paused ? 'play' : 'pause';
    playing = audio.paused ? true : false;
    audio[method]();
  };
  
  const toggleSongPanel = () => {
  
    if (!trackSwitch) {
      // Scale the disc
      spinnerDisc.classList.toggle('scale');
  
      // Show / hide song panel
      songPanel.classList.toggle('playing');
  
      // Change button icon
      playButton.classList.toggle('playing');
    }
  };
  
  const startSpin = () => {
    // Start spinning the disc
    spinner.classList.add('spin');
  };
  
  const stopSpin = () => {
    // Stop spinning the disc
    const spin = document.querySelector('.spin');
    spin.addEventListener("animationiteration", () => {
      if (!playing) {
        spin.style.animation = 'none';
        spinner.classList.remove('spin');
        spin.style.animation = '';
      }
    }, {
      once: true
    });
  };
  
  const handleProgress = () => {
    // Update the progress bar.
    const percent = (audio.currentTime / audio.duration) * 100;
    progressBar.style.flexBasis = `${percent}%`;
    
    // Skip to next track if at the end of the song.
    if (percent === 100) {
      trackSwitch = true;
      handleForwardButton();
    }
  };
  
  const handleBackButton = () => {
    if (audio.currentTime <= 3) {
      const currentTrackId = parseInt(audioSource.dataset.trackid);
      const previousTrackId = currentTrackId === 1 ? '10' : (currentTrackId - 1).toString();
      const previousTrack = tracks.find(o => o.id === previousTrackId);
      changeTrack(previousTrack);
    } else {
      audio.currentTime = 0;
    }
  };
  
  const handleForwardButton = () => {
    const currentTrackId = parseInt(audioSource.dataset.trackid);
    const nextTrackId = currentTrackId === 10 ? '1' : (currentTrackId + 1).toString();
    const nextTrack = tracks.find(o => o.id === nextTrackId);
    changeTrack(nextTrack);
  };
  
  const changeTrack = (track) => {
    if (playing) trackSwitch = true;
    audioSource.setAttribute('src', track.src);
    audioSource.dataset.trackid = track.id;
    songTitle.innerHTML = track.title;
    songArtist.innerHTML = track.artist;
    spinnerDisc.style.backgroundImage = `url(${track.cover})`;
    audio.load();
    if (playing) {
      audio.addEventListener('canplay', () => {
        audio.play();
      }, {
        once: true
      });
      audio.addEventListener('play', () => {
        trackSwitch = false;
      }, {
        once: true
      });
    }
  };
  
  function scrub(e) {
      const scrubTime = (e.offsetX / progress.offsetWidth) * audio.duration;
      audio.currentTime = scrubTime;
  }
  
  audio.addEventListener('play', startSpin);
  audio.addEventListener('play', toggleSongPanel);
  audio.addEventListener('pause', stopSpin)
  audio.addEventListener('pause', toggleSongPanel);
  audio.addEventListener('timeupdate', handleProgress);
  
  backButton.addEventListener('click', handleBackButton);
  playButton.addEventListener('click', togglePlay);
  forwardButton.addEventListener('click', handleForwardButton);
  
  let mousedown = false;
  progress.addEventListener('click', scrub);
  progress.addEventListener('mousemove', (e) => mousedown && scrub(e));
  progress.addEventListener('mousedown', () => mousedown = true);
  progress.addEventListener('mouseup', () => mousedown = false);